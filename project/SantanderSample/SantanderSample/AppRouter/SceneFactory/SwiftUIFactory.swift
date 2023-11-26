import UIKit
import BankSample
import NetworkImpl
import BankSampleSwiftUI
import SwiftUI

final class SwiftUIFactory: SceneFactory {
    let loginRouter: LoginRoutingLogic
    let detailRouter: DetailRoutingLogic
    
    init(loginRouter: LoginRoutingLogic, detailRouter: DetailRoutingLogic) {
        self.loginRouter = loginRouter
        self.detailRouter = detailRouter
    }
    
    func makeLogin() -> UIViewController {
        let viewModel = LoginBuider.initialize(
            router: loginRouter,
            client: APIClientImpl(),
            keychain: KeychainManagerImpl(),
            displayProvider: { interactor in
                LoginView.ViewModel(interactor: interactor)
            }
        )
        let view = LoginView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func makeDetail(user: Login.UserAccount) -> UIViewController {
        let viewModel = DetailBuider.initialize(
            request: user.detailRequest,
            router: detailRouter,
            client: APIClientImpl(),
            displayProvider: { interactor in
                DetailView.ViewModel(interactor: interactor)
            }
        )
        let view = DetailView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
