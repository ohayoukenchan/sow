import SwiftUI

public enum CurrentScene: String {
    case signUp
    case memo
    case setting
    case home
}

public enum NavigationDestination {
    case signUp
    case logIn
    case logOut
    case welcome
    case home
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
public final class RouterStore {
    public static let shared: RouterStore = .init()

    @Published private(set) var currentScene: CurrentScene = .signUp
    @Published private(set) var signUpPath = NavigationPath()
    @Published private(set) var settingPath = NavigationPath()
    @Published private(set) var homePath = NavigationPath()
    @Published private(set) var memoPath = NavigationPath()

    func append(destination: NavigationDestination) {
        switch self.currentScene {
        case .signUp:
            self.signUpPath.append(destination)
        case .home:
            self.homePath.append(destination)
        case .memo:
            self.memoPath.append(destination)
        case .setting:
            self.settingPath.append(destination)
        }
    }

    func popToRoot(of scene: CurrentScene) {
        switch scene {
        case .signUp:
            self.signUpPath = NavigationPath()
        case .memo:
            self.memoPath = NavigationPath()
        case .setting:
            self.settingPath = NavigationPath()
        case .home:
            self.homePath = NavigationPath()
        }
    }

    func pop(of scene: CurrentScene) {
        switch scene {
        case .signUp:
            self.signUpPath.removeLast()
        case .home:
            self.homePath.removeLast()
        case .setting:
            self.settingPath.removeLast()
        case .memo:
            self.memoPath.removeLast()
        }
    }

    func changeScene(nextScene: CurrentScene) {
        currentScene = nextScene
    }

    func getCurrentScene() -> CurrentScene {
        currentScene
    }

    public func clearAllState() {
        signUpPath = NavigationPath()
        settingPath = NavigationPath()
        homePath = NavigationPath()
        memoPath = NavigationPath()
    }
}
