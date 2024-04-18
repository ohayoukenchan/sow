import FirebaseAuth

public class AuthUserRepositoryImpl: AuthUserRepository {
    public init() {
        observeAuthChanges()
    }

    // ログインするメソッド
    public func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if result != nil, error == nil {
                    // self?.isAuthenticated = true
                }
            }
        }
    }

    // 新規登録するメソッド
    public func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if result != nil, error == nil {
                    // self?.isAuthenticated = true
                }
            }
        }
    }

    // パスワードをリセットするメソッド
    public func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                print("Error in sending password reset: \(error)")
            }
        }
    }

    // ログアウトするメソッド
    public func signOut() {
        do {
            try Auth.auth().signOut()
            // isAuthenticated = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    private func observeAuthChanges() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                // self?.isAuthenticated = user != nil
            }
        }
    }
}
