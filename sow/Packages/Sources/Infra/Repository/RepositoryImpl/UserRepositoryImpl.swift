import Core
import FirebaseFirestore

public final class UserRepositoryImpl: UserRepository {
    public init() {}

    public func fetchUser(uid: String) -> Core.User {
        Firestore.firestore().collection("users").document(uid).setData(["name": "Taro"] as [String: Any]) { (err) in
            if let err {
                print("Firestoreへの保存に失敗しました。\(err)")
                // ユーザー情報の登録が失敗した時の処理
                return
            }
            print("Firestoreへの保存に成功しました。")
            // ユーザー情報の登録が完了した時の処理
            // self.delegate?.completedRegisterUserInfoAction()
        }

        let user = User(name: "taro")
        return user
    }
}
