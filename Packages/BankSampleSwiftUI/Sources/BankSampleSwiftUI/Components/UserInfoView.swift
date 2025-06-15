import SwiftUI

struct UserInfoViewModel {
    var name = ""
    var account = ""
    var balance = ""
}

struct UserInfoView: View {
    let viewModel: UserInfoViewModel
    let closeAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                TitleView(text: viewModel.name)
                
                Spacer()
                
                CloseButton(action: closeAction)
            }
            
            HeaderView(
                title: "Conta",
                value: viewModel.account
            )
            
            HeaderView(
                title: "Saldo",
                value: viewModel.balance
            )
            .padding(.bottom, 24)
        }
        .background(Color.blueApp)
    }
}
