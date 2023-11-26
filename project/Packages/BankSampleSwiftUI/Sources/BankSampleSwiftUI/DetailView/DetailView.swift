import SwiftUI
import BankSample

public extension DetailView {
    final class ViewModel: ObservableObject, DetailDisplayLogic {
        @Published var user = UserInfoViewModel()
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
            UserInfoView(
                viewModel: viewModel.user,
                closeAction: {
                    viewModel.close()
                }
            )
            
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
