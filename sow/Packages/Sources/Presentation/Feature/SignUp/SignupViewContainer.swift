import SwiftUI

public struct SignupViewContainer: View {
    private let viewState: SignupViewState

    public init(
        viewState: SignupViewState
    ) {
        self.viewState = viewState
    }

    public var body: some View {
        SignupView()
    }
}
