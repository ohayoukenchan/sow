import Combine
import Infra

@MainActor
final class AuthUserStore {
    static let shared: AuthUserStore = .init()

    @Published private(set) var isLogin: Bool =
        .init(
            false
        )

    func setIsLoggedIn(_ isLoggedIn: Bool) {
        isLogin = isLoggedIn
    }
}
