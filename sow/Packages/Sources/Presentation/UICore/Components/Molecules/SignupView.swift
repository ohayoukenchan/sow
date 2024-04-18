import SwiftUI

public struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    public init() {}

    public var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Sign Up") {}
        }
    }
}
