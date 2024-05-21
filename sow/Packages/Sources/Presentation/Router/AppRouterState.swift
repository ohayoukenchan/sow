import Combine
import Core
import Infra
import SwiftUI

public enum AppRouterAction {
    case navigate(to: NavigationDestination)
    case popToRoot(of: CurrentScene)
    case pop(of: CurrentScene)
    case changeScene(nextScene: CurrentScene)
    case clearAllState
}

@MainActor
public final class AppRouterState: ObservableObject {
    @Published public var currentScene: CurrentScene = .signUp
    @Published public var signUpPath: NavigationPath = .init()
    @Published public var settingPath: NavigationPath = .init()
    @Published public var homePath: NavigationPath = .init()
    @Published public var memoPath: NavigationPath = .init()

    private var cancellables: Set<AnyCancellable> = []

    public init() {
        RouterStore.shared.$currentScene.assign(to: &$currentScene)
        RouterStore.shared.$signUpPath.assign(to: &$signUpPath)
        RouterStore.shared.$settingPath.assign(to: &$settingPath)
        RouterStore.shared.$homePath.assign(to: &$homePath)
        RouterStore.shared.$memoPath.assign(to: &$memoPath)
    }

    public func dispatch(_ action: AppRouterAction) {
        switch action {
        case let .navigate(to: destination):
            navigate(to: destination)
        case let .popToRoot(of: scene):
            popToRoot(of: scene)
        case let .pop(of: scene):
            pop(of: scene)
        case let .changeScene(nextScene: nextScene):
            changeScene(nextScene: nextScene)
        case .clearAllState:
            clearAllState()
        }
    }

    private func navigate(to destination: NavigationDestination) {
        RouterStore.shared.append(destination: destination)
    }

    private func popToRoot(of scene: CurrentScene) {
        RouterStore.shared.popToRoot(of: scene)
    }

    private func pop(of scene: CurrentScene) {
        RouterStore.shared.pop(of: scene)
    }

    private func changeScene(nextScene: CurrentScene) {
        RouterStore.shared.changeScene(nextScene: nextScene)
    }

    private func getCurrentScene() -> CurrentScene {
        RouterStore.shared.getCurrentScene()
    }

    public func clearAllState() {
        RouterStore.shared.clearAllState()
    }
}
