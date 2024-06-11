import Combine
import Core
import Infra

public enum HomeViewAction {
    case fetchUser
}

@MainActor
public final class HomeViewState: ObservableObject {
    @Published public var user: User? = nil
    @Published private(set) var uid: String? = nil

    private let presenter: UserPresenter?

    private var cancellables: Set<AnyCancellable> = []

    public init(presenter: UserPresenter?) {
        self.presenter = presenter

        UserStore.shared.$user.assign(to: &$user)
        AuthUserStore.shared.$uid.assign(to: &$uid)
    }

    public func dispatch(_ action: HomeViewAction) {
        switch action {
        case .fetchUser:
            fetchUser()
        }
    }

    private func fetchUser() {
        guard let uid else { return }

        let user = presenter?.fetchUser(uid: uid)

        guard let user else { return }

        UserStore.shared.saveUser(user: user)
    }
}
