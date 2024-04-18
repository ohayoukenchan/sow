import Infra

public final class AuthPresenter {
    private let useCase: AuthUserUseCase

    public init(useCase: AuthUserUseCase) {
        self.useCase = useCase
    }

    public func isAuthenticated() -> Bool {
        false
    }
}
