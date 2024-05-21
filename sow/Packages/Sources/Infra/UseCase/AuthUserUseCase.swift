import Foundation

public final class AuthUserUseCase {
    private let authUserRepository: AuthUserRepository

    public init(authRepository: AuthUserRepository) {
        self.authUserRepository = authRepository
    }

    public func authUser() {
        // authUserRepository.observeAuthChanges()
    }

    public func signUp(email: String, password: String) async throws {
        do {
            try await authUserRepository.signUp(email: email, password: password)
        } catch {
            throw error
        }
    }

    public func signIn(email: String, password: String) async throws {
        do {
            try await authUserRepository.signIn(email: email, password: password)
        } catch {
            throw error
        }
    }

    public func signOut() throws {
        do {
            try authUserRepository.signOut()
        } catch {
            throw error
        }
    }
}
