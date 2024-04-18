import FirebaseCore
import Presentation
import SwiftUI

@main
struct sowApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // TODO: あとでUserの情報をちゃんと取得する
    let isAuthenticated = false

    let viewBuilder = DependencyBuilder.shared

    var body: some Scene {
        WindowGroup {
            RouterContainer(content: {
                viewBuilder.build(screenType: .signup)
            }, navigation: isAuthenticated ? .constant([]) : .constant([]))
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}
