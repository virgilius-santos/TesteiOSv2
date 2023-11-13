import SwiftUI
import BankSample

extension LoginView {
    @MainActor
    public final class ViewModel: ObservableObject {
        @MainActor @Published var user = ""
        @MainActor @Published var password = ""
        
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
        
        func set(user: String?) async {
            self.user = user ?? ""
        }
        
        func set(password: String?) async {
            self.password = password ?? ""
        }
    }
}

public struct LoginView: View {
    @StateObject private var viewModel: ViewModel
    
    public var body: some View {
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
        // TODO: To be defined
    }
    
    public nonisolated func stopLoading() {
        // TODO: To be defined
    }
    
    public nonisolated func displayError(viewModel: BankSample.Login.ErrorViewModel) {
        // TODO: To be defined
    }
    
    public nonisolated func displayLastUser(viewModel: BankSample.Login.LastUserViewModel) {
        Task {
            await set(user: viewModel.user)
            await set(password: viewModel.password)
        }
    }
}
