public struct ApiErrorResponse: Error, Decodable {
    public let errors: [ApiError]

    /// unkeyedContainer() メソッドを使用して、JSONデータ内の配列を取得し、その中に含まれる複数の ApiError オブジェクトをデコードして apiErrors 配列に追加します。
    /// Apiから返却されるエラーが複数ある場合に用いる

    /// これはAPIの仕様により不要かもしれません
    public init(from decoder: Decoder) throws {
        var apiErrors: [ApiError] = []
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let error = try container.decode(ApiError.self)
            apiErrors.append(error)
        }
        errors = apiErrors
    }
}

extension ApiErrorResponse {
    init(errors: [ApiError]) {
        self.errors = errors
    }
}
