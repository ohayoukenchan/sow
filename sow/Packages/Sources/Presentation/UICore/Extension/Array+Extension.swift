import Foundation

extension Array {
    /// Arrayのインデックスをチェックして、範囲外の場合はnilを返す
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
