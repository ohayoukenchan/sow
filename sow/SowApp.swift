import FirebaseCore
import FirebaseFirestore
import Presentation
import SwiftUI

@main
struct SowApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var appRouterState = AppRouterState()

    var body: some Scene {
        WindowGroup {
            AppRootContainer()
                .environmentObject(appRouterState)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}
