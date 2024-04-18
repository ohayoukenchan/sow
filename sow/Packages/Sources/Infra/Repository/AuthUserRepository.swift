public protocol AuthUserRepository {
    func signIn(email: String, password: String)
    func signUp(email: String, password: String)
    func resetPassword(email: String)
    func signOut()
    // func observeAuthChanges()
}
