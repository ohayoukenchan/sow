import SwiftUI

public struct RouterContainer<Content>: View where Content: View {
    @ViewBuilder let content: () -> Content
    let navigation: Binding<[NavigationDestination]>

    let viewBuilder = DependencyBuilder.shared

    public init(content: @escaping () -> Content, navigation: Binding<[NavigationDestination]>) {
        self.content = content
        self.navigation = navigation
    }

    public var body: some View {
        NavigationStack(path: navigation) {
            VStack {
                content()
            }.navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .signup:
                    viewBuilder.build(screenType: .signup)
                }
            }
        }
    }
}
