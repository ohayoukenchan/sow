public struct Page: Codable, Sendable {
    public var title: String

    public var description: String

    public var url: String

    public init(title: String, description: String, url: String) {
        self.title = title
        self.description = description
        self.url = url
    }
}
