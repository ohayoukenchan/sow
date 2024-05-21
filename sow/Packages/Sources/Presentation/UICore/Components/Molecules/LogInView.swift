import SwiftUI

public struct LogInView: View {
    @Binding var email: String
    @Binding var password: String
    var onTapAction: () -> Void

    public init(email: Binding<String>, password: Binding<String>, onTapAction: @escaping () -> Void) {
        _email = email
        _password = password
        self.onTapAction = onTapAction
    }

    public var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("LogIn") {
                onTapAction()
            }
        }
    }
}
