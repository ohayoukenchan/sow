import Core

public final class UserRepositoryImpl: UserRepository {
    public init() {}

    public func fetchUser() -> User {
        let user = User(name: "taro")
        return user
    }
}
