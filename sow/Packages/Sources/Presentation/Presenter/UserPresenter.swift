import Core
import Infra

public final class UserPresenter {
    private let useCase: UserUseCase

    public init(useCase: UserUseCase) {
        self.useCase = useCase
    }

    public func isAuthenticated() -> Bool {
        false
    }

    public func fetchUser() -> User {
        useCase.fetchUser()
    }
}