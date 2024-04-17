import UIKit

public final class AppearanceUtil {
    public static func appearance() {
        // UINavigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .sow.monotone8
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance

        // UIBarButtonItem
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self])
            .tintColor = .sow.monotone1
    }
}
