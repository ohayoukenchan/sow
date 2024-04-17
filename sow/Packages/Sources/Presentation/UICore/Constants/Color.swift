import SwiftUI
import UIKit

public extension Color {
    enum accentColor {
        static let red = Color("accentColor", bundle: .module)
    }
}

public extension UIColor {
    enum accentColor {
        static let red = UIColor(Color.accentColor.red)
    }
}
