import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button.init(
            action: action,
            label: {
                Image("logout 2")
            }
        )
        .padding(8)
        .background(Color.blueApp)
        .frame(minWidth: 44, minHeight: 44)
        .padding(.trailing, 16)
    }
}
