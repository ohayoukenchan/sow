public struct Theme: Codable, Sendable {
    public var title: String

    public var description: String

    public var pages: [Page]

    public init(title: String, description: String, pages: [Page]) {
        self.title = title
        self.description = description
        self.pages = pages
    }
}
