import SwiftUI

struct InputView: View {
    let title: String
    let isSecure: Bool
    
    @Binding var text: String
    
    var body: some View {
        field
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.grayApp, lineWidth: 2)
            )
            .padding([.horizontal, .top], 24)
    }
    
    @ViewBuilder
    var field: some View {
        if isSecure {
            SecureField(title, text: $text)
        } else {
            TextField(title, text: $text)
        }
    }
}
