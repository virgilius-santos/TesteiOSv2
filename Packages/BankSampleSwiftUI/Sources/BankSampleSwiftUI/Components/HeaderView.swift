import SwiftUI

struct HeaderView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TitleView(text: title)
            InfoView(text: value)
        }
    }
}
