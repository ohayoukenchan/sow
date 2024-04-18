import SwiftUI

public enum CurrentScene: String {
    case signup
}

public enum NavigationDestination {
    case signup
}

extension NavigationDestination: Hashable {
    var identifier: String {
        UUID().uuidString
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    public static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

@MainActor
final class RouterStore {
    @Published private(set) var currentScene: CurrentScene = .signup
    @Published private(set) var signupPath: [NavigationDestination] = []

    func append(destination: NavigationDestination) {
        switch self.currentScene {
        case .signup:
            self.signupPath.append(destination)
        }
    }

    func popToRoot(of scene: CurrentScene) {
        switch scene {
        case .signup:
            self.signupPath.removeAll()
        }
    }

    func pop(of scene: CurrentScene) {
        switch scene {
        case .signup:
            self.signupPath.removeLast()
        }
    }

    func changeScene(nextScene: CurrentScene) {
        currentScene = nextScene
    }

    func getCurrentScene() -> CurrentScene {
        currentScene
    }

    public func clearAllState() {
        signupPath.removeAll()
    }
}
