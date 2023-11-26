import SwiftUI

struct TitleView: View {
    let text: String
    var foregroundColor = Color.white
    
    var body: some View {
        Text(text)
            .lineLimit(.zero)
            .foregroundColor(foregroundColor)
            .font(Font.subheadline)
            .padding(.horizontal, 16)
            .accessibilityAddTraits(.isHeader)
            .fixedSize(horizontal: false, vertical: true)
    }
}
