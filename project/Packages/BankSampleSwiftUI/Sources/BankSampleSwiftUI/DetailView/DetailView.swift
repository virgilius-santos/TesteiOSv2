import SwiftUI
import BankSample

public extension DetailView {
    final class ViewModel: ObservableObject, DetailDisplayLogic {
        struct UserInfo {
            var name = ""
            var account = ""
            var balance = ""
        }
        
        struct Statement: Identifiable {
            var id = UUID()
            let title: String
            let date: String
            let info: String
            let price: String
        }
        
        @Published var user = UserInfo()
        @Published var statements = [Statement]()
        
        let interactor: DetailBusinessLogic
        
        public init(interactor: DetailBusinessLogic) {
            self.interactor = interactor
        }
        
        func close() {
            interactor.logout()
        }
        
        func loadData() {
            interactor.getDetails()
        }
        
        @MainActor
        func update(userViewModel: Detail.ViewModel) {
            user = .init(
                name: userViewModel.name ?? "",
                account: userViewModel.account ?? "",
                balance: userViewModel.balance ?? ""
            )
        }
        
        @MainActor
        func update(statementsViewModel: [Detail.StatementViewModel]) {
            statements = statementsViewModel.map {
                .init(
                    title: $0.title ?? "",
                    date: $0.date ?? "",
                    info: $0.desc ?? "",
                    price: $0.value ?? ""
                )
            }
        }
        
        public func startLoading() {
            // TODO: Next Change
        }
        
        public func stopLoading() {
            // TODO: Next Change
        }
        
        public func displayUserInfo(viewModel: Detail.ViewModel) {
            Task {
                await self.update(userViewModel: viewModel)
            }
        }
        
        public func displayDetail(_ detailList: [Detail.StatementViewModel]) {
            Task {
                await self.update(statementsViewModel: detailList)
            }
        }
    }
}

public struct DetailView: View {
    @StateObject private var viewModel: ViewModel
    
    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    TitleView(text: viewModel.user.name)
                    
                    Spacer()
                    
                    CloseButton {
                        viewModel.close()
                    }
                }
                
                HeaderView(
                    title: "Conta",
                    value: viewModel.user.account
                )
                
                HeaderView(
                    title: "Saldo",
                    value: viewModel.user.balance
                )
                .padding(.bottom, 24)
            }
            .background(Color.blueApp)
            
            TitleView(
                text: "Recents",
                foregroundColor: Color.blueApp
            )
            
            List {
                ForEach(viewModel.statements) { item in
                    card(item: item)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 4)
                        .background(.clear)
                        .foregroundColor(Color.white)
                        .padding(8)
                )
            }
        }
        .background(Color.grayApp)
        .onAppear {
            viewModel.loadData()
        }
    }
    
    public init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    @ViewBuilder
    func card(item: DetailView.ViewModel.Statement) -> some View {
        VStack {
            HStack {
                Text(item.title)
                    .font(.caption)
                Spacer()
                Text(item.date)
                    .font(.caption)
            }
            .padding(.bottom, 16)
            
            HStack {
                Text(item.info)
                    .font(.body)
                Spacer()
                Text(item.price)
                    .font(.body)
            }
        }
        .padding(8)
    }
}

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
