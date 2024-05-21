import Infra

public final class AuthPresenter {
    private let useCase: AuthUserUseCase

    public init(useCase: AuthUserUseCase) {
        self.useCase = useCase
    }

    public func isAuthenticated() -> Bool {
        false
    }

    public func signUp(email: String, password: String) async throws {
        do {
            try await useCase.signUp(email: email, password: password)
        } catch {
            throw error
        }
    }

    public func signIn(email: String, password: String) async throws {
        do {
            try await useCase.signIn(email: email, password: password)
        } catch {
            throw error
        }
    }

    public func signOut() throws {
        do {
            try useCase.signOut()
        } catch {
            throw error
        }
    }
}
