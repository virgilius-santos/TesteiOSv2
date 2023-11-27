import SwiftUI
import BankSample

extension LoginView {
    public final class ViewModel: ObservableObject {
        struct Error: LocalizedError {
            var errorDescription: String? = "Error"
            var recoverySuggestion: String?
        }
        
        @Published var user = ""
        @Published var password = ""
        @Published var loading = false
        @Published var error: Swift.Error?
        
        let interactor: LoginBusinessLogic
        
        public init(interactor: LoginBusinessLogic) {
            self.interactor = interactor
        }
        
        func auth() {
            interactor.auth(request: .init(user: user, password: password))
        }
        
        func loadLastUser() {
            interactor.getLastUser()
        }
        
        @MainActor
        func set(error: Error) async {
            self.error = error
        }
        
        @MainActor
        func set(loading: Bool) async {
            self.loading = loading
        }
        
        @MainActor
        func set(user: String?) async {
            self.user = user ?? ""
        }
        
        @MainActor
        func set(password: String?) async {
            self.password = password ?? ""
        }
    }
}

public struct LoginView: View {
    @StateObject private var viewModel: ViewModel
    
    public var body: some View {
        LoadingView(loading: $viewModel.loading) {
            VStack {
                VStack(alignment: .center) {
                    Image("Logo")
                        .frame(width: 125, height: 70)
                    
                    Spacer()
                    
                    InputView(title: "User", isSecure: false, text: $viewModel.user)
                    
                    InputView(title: "Password", isSecure: true, text: $viewModel.password)
                    
                    ButtonApp(title: "Login") {
                        viewModel.auth()
                    }
                }
                .frame(height: 300)
                .onAppear {
                    viewModel.loadLastUser()
                }
                
                Spacer()
            }
        }
        .errorAlert(error: $viewModel.error)
    }
    
    public init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    final class Mock: LoginBusinessLogic {
        func auth(request: BankSample.Login.Request) {}
        func getLastUser() {}
    }
    
    static var previews: some View {
        LoginView(viewModel: .init(interactor: Mock()))
    }
}

extension LoginView.ViewModel: LoginDisplayLogic {
    public nonisolated func startLoading() {
        Task {
            await set(loading: true)
        }
    }
    
    public nonisolated func stopLoading() {
        Task {
            await set(loading: false)
        }
    }
    
    public nonisolated func displayError(viewModel: Login.ErrorViewModel) {
        Task {
            await set(error: .init(recoverySuggestion: viewModel.error))
        }
    }
    
    public nonisolated func displayLastUser(viewModel: BankSample.Login.LastUserViewModel) {
        Task {
            await set(user: viewModel.user)
            await set(password: viewModel.password)
        }
    }
}
