import SwiftUI

public struct SignUpViewContainer: View {
    @ObservedObject var viewState: SignUpViewState

    public init(
        viewState: SignUpViewState
    ) {
        self.viewState = viewState
    }

    public var body: some View {
        SignUpView(
            email: $viewState.email,
            password: $viewState.password,
            onTapAction: viewState.onTap
        )
    }
}
