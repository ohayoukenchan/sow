import FirebaseAuth
import FirebaseCore

@testable import Core
@testable import Infra

final class MockAuthUserRepository: AuthUserRepository {
    var isSignInCalled = false

    // ここに返却する値を保持させる
    var authErrorCode: AuthErrorCode?

    private var isAlredyRegistered = false

    func signIn(email: String, password: String) async throws {
        isSignInCalled = true
        do {
            try mockSignIn()
        } catch {
            if let error = error as? AuthErrorCode {
                throw error
            }
        }
    }

    func signUp(email: String, password: String) async throws {}

    func resetPassword(email: String) async throws {}

    func signOut() throws {}

    private func mockSignIn() throws {
        throw AuthErrorCode(.emailAlreadyInUse)
    }
}
