import FirebaseAuth

public class AuthUserRepositoryImpl: AuthUserRepository {
    private var handler: AuthStateDidChangeListenerHandle?

    public init() {}

    // ログインするメソッド
    public func signIn(email: String, password: String) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw error
        }
    }

    // 新規登録するメソッド
    public func signUp(email: String, password: String) async throws {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            throw error
        }
    }

    // パスワードをリセットするメソッド
    public func resetPassword(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            throw error
        }
    }

    // ログアウトするメソッド
    public func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
