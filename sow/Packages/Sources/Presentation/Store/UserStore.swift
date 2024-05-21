import Combine
import Core

@MainActor
public final class UserStore {
    public static let shared: UserStore = .init()

    @Published private(set) var user: User? = nil

    private init() {}

    public func saveUser(user: User) {
        self.user = user
    }
}
