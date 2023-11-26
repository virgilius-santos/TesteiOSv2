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
        let display = LoginBuider.initialize(
            router: loginRouter,
            client: APIClientImpl(),
            keychain: KeychainManagerImpl(),
            displayProvider: { interactor in
                LoginView.ViewModel(interactor: interactor)
            }
        )
        let view = LoginView(viewModel: display)
        return UIHostingController(rootView: view)
    }
    
    func makeDetail(user: Login.UserAccount) -> UIViewController {
        .init()
    }
}
