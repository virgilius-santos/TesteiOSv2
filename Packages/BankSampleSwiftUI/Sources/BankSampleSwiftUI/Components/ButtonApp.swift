import SwiftUI

struct ButtonApp: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(minWidth: 200, minHeight: 44)
        }
        .buttonStyle(.borderedProminent)
        .tint(.blueApp)
        .padding(.top, 50)
    }
}
