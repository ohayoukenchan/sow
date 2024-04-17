import Foundation

@testable import Infra

@MainActor
public final class MockAPIService: ApiService {
    var stubs: [Any] = []
    var request: (any ApiRequest)?

    deinit {
        stubs = []
    }

    public func stub<Request>(
        for type: Request.Type,
        response: @escaping ((Request) throws -> Request.Response)
    ) where Request: ApiRequest {
        stubs.append(response)
    }

    public func call<Request>(from request: Request) async throws -> Request.Response
        where Request: ApiRequest {
        let stubRequest = await getStubRequest(from: request)

        guard let stubRequest else {
            throw APIServiceError.responseError(NSError())
        }

        do {
            self.request = request
            return try stubRequest(request)
        } catch {
            throw error
        }
    }

    private func getStubRequest<Request>(from request: Request) async -> (
        (Request) throws -> Request.Response
    )? where Request: ApiRequest {
        typealias StubRequest = ((Request) throws -> Request.Response)

        if let index = stubs.firstIndex(where: { $0 is StubRequest }) {
            let stubRequest = stubs[index] as? StubRequest
            stubs.remove(at: index)
            return stubRequest
        }
        return nil
    }

    public func call<Request>(from request: Request, maxRetries: Int, retryDelay: UInt64) async throws
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
