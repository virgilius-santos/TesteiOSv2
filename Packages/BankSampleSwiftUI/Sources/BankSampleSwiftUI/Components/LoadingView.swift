import SwiftUI

struct LoadingView<Content: View>: View {
    @Binding var loading: Bool
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        if loading {
            VStack(alignment: .center) {
                Spacer()
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(Color.blueApp)
                    Spacer()
                }
                Spacer()
            }
            .background {
                Color.grayApp
                    .opacity(0.15)
            }
        } else {
            content()
        }
    }
}
