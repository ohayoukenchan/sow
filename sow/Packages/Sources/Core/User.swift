public struct User: Codable, Sendable {
    public var name: String

    public init(name: String) {
        self.name = name
    }
}
