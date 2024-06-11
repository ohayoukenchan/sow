import Core
import Foundation

public protocol UserRepository {
    func createUser(uid: String, user: User)
    func fetchUser(uid: String) -> User
}
