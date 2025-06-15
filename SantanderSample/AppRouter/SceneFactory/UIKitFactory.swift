import UIKit
import BankSample
import NetworkImpl
import BankSampleUIKit

protocol HasUIKitFactory {
    var uiKitFactory: SceneFactory { get }
}

final class UIKitFactory: SceneFactory {
    typealias Dependencies = HasLoginRoutingLogic & HasDetailRoutingLogic
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeLogin() -> UIViewController {
        LoginBuider.initialize(
            router: dependencies.loginRouter,
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
            router: dependencies.detailRouter,
            client: APIClientImpl(),
            displayProvider: DetailsViewViewController.init(interactor:)
        )
    }
}
