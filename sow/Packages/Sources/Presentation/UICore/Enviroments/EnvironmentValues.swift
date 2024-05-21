import SwiftUI

private struct SubscribedAuthEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

private struct UIDEnvironmentKey: EnvironmentKey {
    static let defaultValue: String? = nil
}

@MainActor
private struct AppRouterStateKey: EnvironmentKey {
    static let defaultValue: AppRouterState = .init()
}

public extension EnvironmentValues {
    var uid: String? {
        get { self[UIDEnvironmentKey.self] }
        set { self[UIDEnvironmentKey.self] = newValue }
    }

    var subscribedAuth: Bool {
        get { self[SubscribedAuthEnvironmentKey.self] }
        set { self[SubscribedAuthEnvironmentKey.self] = newValue }
    }

    var appRouterState: AppRouterState {
        get { self[AppRouterStateKey.self] }
        set { self[AppRouterStateKey.self] = newValue }
    }
}
