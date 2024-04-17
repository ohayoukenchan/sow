import Foundation
import Infra
import UIKit

/// 👷‍♀UIKitの関心なのでFeatureなどに移す
final class ApiErrorHandler {
    static func handle(
        error: APIServiceError,
        controller: UIViewController?,
        action: UIAlertAction? = nil
    ) {
        switch error.primaryError?.code {
        default:
            let title = "エラー"
            let message = error.primaryError?.message ?? "通信エラーが発生しました。再試行してください。"
            let action = action ?? UIAlertAction(title: "OK", style: .default, handler: nil)

            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(action)
            controller?.present(alert, animated: true, completion: nil)
        }
    }
}
