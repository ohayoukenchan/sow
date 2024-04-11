public struct ApiError: Error, Decodable {
    /// Errorプロトコルを拡張したもの
    init(code: Int, message: String, resource: String? = nil, field: String? = nil) {
        self.code = code
        self.message = message
        self.resource = resource
        self.field = field
    }

    public var code: Int

    public var message: String

    public var resource: String?

    public var field: String?
}
