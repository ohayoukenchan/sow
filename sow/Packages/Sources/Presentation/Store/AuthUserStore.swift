import Combine
import FirebaseAuth
import Infra

@MainActor
public final class AuthUserStore {
    public static let shared: AuthUserStore = .init()

    @Published private(set) var isSubscribed: Bool = false
    @Published private(set) var uid: String? = nil

    private var listener: AuthStateDidChangeListenerHandle!

    private init() {
        self.listener = Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            if let _ = user {
                self?.isSubscribed = true
                self?.uid = user?.uid
            } else {
                self?.isSubscribed = false
            }
        }
    }

    deinit {
        Auth.auth().removeStateDidChangeListener(listener!)
        Task { @MainActor in
            self.isSubscribed = false
        }
    }
}
