import Core

final class UserUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func fetchUser() -> User {
        userRepository.fetchUser()
    }
}
