import SwiftUI

// 条件でモディファイアを追加するかしないかを分岐するためのextension
// Viewにブロックで指定したモディファイアをつけてViewとして返すのでSwiftUIのチェインを崩さないですむ
extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}
