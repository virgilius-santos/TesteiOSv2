import UIKit
import BankSample
import NetworkImpl
import BankSampleUIKit

final class UIKitFactory: SceneFactory {
    let loginRouter: LoginRoutingLogic
    let detailRouter: DetailRoutingLogic
    
    init(loginRouter: LoginRoutingLogic, detailRouter: DetailRoutingLogic) {
        self.loginRouter = loginRouter
        self.detailRouter = detailRouter
    }
    
    func makeLogin() -> UIViewController {
        LoginBuider.initialize(
            router: loginRouter,
            client: APIClientImpl(),
            keychain: KeychainManagerImpl(),
            displayProvider: { interactor in
                LoginViewController(
                    interactor: interactor,
                    keyboardManager: KeyboardManagerImpl()
                )
            }
        )
    }
    
    func makeDetail(user: Login.UserAccount) -> UIViewController {
        DetailBuider.initialize(
            request: user.detailRequest,
            router: detailRouter,
            client: APIClientImpl(),
            displayProvider: DetailsViewViewController.init(interactor:)
        )
    }
}
