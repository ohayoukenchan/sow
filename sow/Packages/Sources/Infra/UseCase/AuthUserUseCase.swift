public final class AuthUserUseCase {
    private let authUserRepository: AuthUserRepository

    public init(authRepository: AuthUserRepository) {
        self.authUserRepository = authRepository
    }

    public func authUser() {
        // authUserRepository.observeAuthChanges()
    }
}
