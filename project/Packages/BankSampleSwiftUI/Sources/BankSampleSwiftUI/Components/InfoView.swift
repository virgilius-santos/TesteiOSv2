import SwiftUI

struct InfoView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .lineLimit(.zero)
            .foregroundColor(Color.white)
            .font(Font.headline)
            .padding(.horizontal, 16)
            .fixedSize(horizontal: false, vertical: true)
    }
}
