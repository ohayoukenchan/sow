import SwiftUI

public struct AppRootContainer: View {
    @StateObject var authUserState = AuthUserState()

    var viewFactory = ViewFactory.shared

    public init() {}

    public var body: some View {
        if authUserState.isSubscribed {
            viewFactory.build(screenType: .home)
        } else {
            viewFactory.build(screenType: .welcome)
        }
    }
}

#Preview {
    AppRootContainer()
}
