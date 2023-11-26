import SwiftUI
import BankSample

public extension DetailView {
    final class ViewModel: ObservableObject, DetailDisplayLogic {
        struct UserInfo {
            var name = ""
            var account = ""
            var balance = ""
        }
        
        @Published var user = UserInfo()
        @Published var statements = [CardViewModel]()
        
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
                    CardView(viewModel: item)
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
}
