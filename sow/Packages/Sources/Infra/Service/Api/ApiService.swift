import Foundation

public protocol ApiService: Sendable {
    func call<Request>(from request: Request) async throws -> Request.Response
    where Request: ApiRequest

    func call<Request>(from request: Request, maxRetries: Int, retryDelay: UInt64)
        async throws
        -> Request.Response where Request: ApiRequest
}

public final class DefaultApiService: ApiService {

    public init() {}

    public func call<Request>(from request: Request) async throws -> Request.Response
    where Request: ApiRequest {
        let urlRequest: URLRequest = request.buildRequest()

        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: urlRequest) {
                data,
                response,
                error in
                if let error = error {
                    continuation.resume(with: .failure(error))
                } else {
                    guard let data = data else {
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
                            } catch let error {
                                continuation.resume(with: .failure(error))
                            }
                        default:
                            do {
                                let error = try decoder.decode(ApiErrorResponse.self, from: data)
                                continuation.resume(
                                    with: .failure(APIServiceError.responseError(error))
                                )
                            } catch let error {
                                continuation.resume(with: .failure(error))
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }

    public func call<Request>(from request: Request, maxRetries: Int, retryDelay: UInt64 = 3)
        async throws
        -> Request.Response
    where Request: ApiRequest {
        var errorResponse: Error?
        for _ in 0..<maxRetries {
            do {
                return try await call(from: request)

            } catch let error {
                errorResponse = error
                // エラーコードが返ってきているときはリトライしない
                if error.primaryError?.code != nil {
                    break
                }
                // リトライ回数分処理を遅らせています。簡易的にやっているので、本来は指数バックオフなどのリトライ戦略を考慮するしてもいいと思います。
                let oneSecond = NSEC_PER_SEC
                let delay = oneSecond * retryDelay

                try await Task.sleep(nanoseconds: delay)

                continue
            }
        }

        throw errorResponse ?? ApiError(code: 101, message: "APIクライアントのretry処理で不明なエラーが発生しました。")
    }
}
