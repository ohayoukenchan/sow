import SwiftUI

public struct RouterContainer<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content

    var navigation: Binding<NavigationPath>

    var viewFactory = ViewFactory.shared

    public init(content: @escaping () -> Content, navigation: Binding<NavigationPath>) {
        self.content = content
        self.navigation = navigation
    }

    public var body: some View {
        NavigationStack(path: navigation) {
            VStack {
                content()
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .signUp:
                    viewFactory.build(screenType: .signUp)
                case .home:
                    viewFactory.build(screenType: .home)
                case .logIn:
                    viewFactory.build(screenType: .logIn)
                case .welcome:
                    viewFactory.build(screenType: .welcome)
                case .logOut:
                    viewFactory.build(screenType: .logOut)
                }
            }
        }
    }
}
