import Core

public final class UserUseCase {
    private let userRepository: UserRepository

    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func fetchUser(uid: String) -> User {
        userRepository.fetchUser(uid: uid)
    }

    public func createUser(uid: String, user: User) {
        userRepository.createUser(uid: uid, user: user)
    }
}
