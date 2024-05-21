public protocol AuthUserRepository {
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func resetPassword(email: String) async throws
    func signOut() throws
    // func observeAuthChanges()
}
