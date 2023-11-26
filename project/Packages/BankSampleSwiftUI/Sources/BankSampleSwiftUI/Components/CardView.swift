import SwiftUI

struct CardViewModel: Identifiable {
    var id = UUID()
    let title: String
    let date: String
    let info: String
    let price: String
}

struct CardView: View {
    let viewModel: CardViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.title)
                    .font(.caption)
                Spacer()
                Text(viewModel.date)
                    .font(.caption)
            }
            .padding(.bottom, 16)
            
            HStack {
                Text(viewModel.info)
                    .font(.body)
                Spacer()
                Text(viewModel.price)
                    .font(.body)
            }
        }
        .padding(8)
    }
}
