import Core

public final class UserUseCase {
    private let userRepository: UserRepository

    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func fetchUser() -> User {
        userRepository.fetchUser()
    }
}
