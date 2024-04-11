import SwiftUI

struct TitleText: View {
    var text: String
    var fontSize: Font
    var fontWeight: Font.Weight = .bold
    var multilineTextAlignment: TextAlignment = .leading

    static let fontColor = SowColors.monotone1

    var body: some View {
        Text(text)
            .font(fontSize)
            .fontWeight(fontWeight)
            .multilineTextAlignment(multilineTextAlignment)
            .foregroundStyle(TitleText.fontColor)
    }
}

#Preview {
    Group {
        TitleText(text: "人気ランキング", fontSize: .body)
    }
}
