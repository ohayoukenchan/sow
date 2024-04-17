import SwiftUI

// 条件でモディファイアを追加するかしないかを分岐するためのextension
// Viewにブロックで指定したモディファイアをつけてViewとして返すのでSwiftUIのチェインを崩さないですむ
extension View {
    @ViewBuilder
    func `if`(_ condition: Bool, content: (Self) -> some View) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}
