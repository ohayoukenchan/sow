import Combine
import Core
import Infra

@MainActor
public final class AuthUserState: ObservableObject {
    @Published public var isSubscribed: Bool = false
    @Published public var uid: String? = nil

    private var cancellables: Set<AnyCancellable> = []

    public init() {
        AuthUserStore.shared.$isSubscribed.assign(to: &$isSubscribed)
        AuthUserStore.shared.$uid.assign(to: &$uid)
    }
}
