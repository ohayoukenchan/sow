import Combine
import Foundation

@testable import Core
@testable import Infra

protocol StubInjection {
    var urlSession: URLSession { get }

    func injectingToMockURLProtocol(using data: Data?)

    func injectingToMockURLProtocol(using data: Data?, statusCode: Int)
}

extension StubInjection {
    func injectingToMockURLProtocol(using data: Data?) {
        MockURLProtocol.requestHandler = { _ in
            (HTTPURLResponse(), data)
        }
    }

    func injectingToMockURLProtocol(using data: Data?, statusCode: Int) {
        MockURLProtocol.requestHandler = { _ in
            (
                HTTPURLResponse(
                    url: URL(string: "http://example.com")!,
                    statusCode: statusCode,
                    httpVersion: nil,
                    headerFields: nil
                )!, data
            )
        }
    }
}

final class StubAPIService: ApiService, StubInjection {
    let urlSession: URLSession

    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }

    func call<Request>(from request: Request) async throws -> Request.Response
        where Request: ApiRequest {
        let urlRequest: URLRequest = request.buildRequest()

        return try await withCheckedThrowingContinuation { continuation in
            let task = urlSession.dataTask(with: urlRequest) {
                data,
                    response,
                    error in
                if let error {
                    continuation.resume(with: .failure(error))
                } else {
                    guard let data else {
                        assertionFailure()
                        continuation.resume(
                            with: .failure(NSError(domain: "error", code: 500, userInfo: nil))
                        )
                        return
                    }
                    if let urlResponse = response as? HTTPURLResponse {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        decoder.keyDecodingStrategy = .convertFromSnakeCase

                        switch urlResponse.statusCode {
                        case 200..<300:
                            do {
                                let json = try decoder.decode(Request.Response.self, from: data)
                                continuation.resume(with: .success(json))
                            } catch {
                                continuation.resume(with: .failure(error))
                            }
                        default:
                            do {
                                let error = try decoder.decode(ApiErrorResponse.self, from: data)
                                let e = APIServiceError.responseError(error)
                                continuation.resume(with: .failure(e))
                            } catch {
                                continuation.resume(with: .failure(error))
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }

    func call<Request>(from request: Request, maxRetries: Int, retryDelay: UInt64) async throws
        -> Request.Response where Request: Infra.ApiRequest {
        var errorResponse: Error?
        for _ in 0..<maxRetries {
            do {
                return try await call(from: request)

            } catch {
                errorResponse = error
                // エラーコードが返ってきているときはリトライしない
                if error.primaryError?.code != nil {
                    break
                }
                let milliseconds = NSEC_PER_MSEC
                let delay = milliseconds * retryDelay

                try await Task.sleep(nanoseconds: delay)

                continue
            }
        }

        throw errorResponse ?? ApiError(code: 101, message: "APIクライアントのretry処理で不明なエラーが発生しました。")
    }
}
