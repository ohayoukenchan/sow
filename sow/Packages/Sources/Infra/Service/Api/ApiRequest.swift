import UIKit

public protocol ApiRequest: Sendable {
    associatedtype Response: Decodable, Sendable

    var path: String { get }

    var queryItems: [URLQueryItem]? { get }

    var bodyParameters: [String: Any]? { get }

    var method: HTTPMethodType { get }

    var baseURL: URL { get }

    var headerFields: [String: String]? { get }

    var basicAuth: String? { get }
}

extension ApiRequest {
    public var queryItems: [URLQueryItem]? { nil }

    public var bodyParameters: [String: Any]? { nil }

    public var basicAuth: String? { nil }

    public func buildRequest() -> URLRequest {
        let pathURL = baseURL.appendingPathComponent(self.path)

        let httpMethod = self.method
        let bodyParameters = self.bodyParameters

        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!

        /// クエリパラメータを設定する
        urlComponents.queryItems = self.queryItems

        if let url = urlComponents.url {
            DebugLogger.print("#API::\(url)")
        }

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = httpMethod.rawValue

        if let headerFields {
            for (key, value) in headerFields {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        if let bodyParameters {
            let jsonData = try? JSONSerialization.data(
                withJSONObject: bodyParameters,
                options: .prettyPrinted
            )
            request.setValue(
                "\(String(describing: jsonData?.count))",
                forHTTPHeaderField: "Content-Length"
            )
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        }

        /// basicAuthなどを設定する必要がでたらこちらに追加していく

        return request
    }
}
