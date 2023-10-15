import UIKit
import Network
import KeyChain
import BankSample
import BankSampleUIKit

final class LoginConfigurator {
    let client: APIClient
    let router: LoginRoutingLogic
    let keychain: KeychainManager
    
    init(
        router: LoginRoutingLogic,
        client: APIClient,
        keychain: KeychainManager
    ) {
        self.router = router
        self.client = client
        self.keychain = keychain
    }
    
    func build() -> UIViewController {
        let displayThreadWrapper = LoginDisplayLogicThreadWrapper()
        let routerThreadWrapper = LoginRoutingLogicThreadWrapper()
        let worker = LoginWorker(client: client, keychain: keychain)
        let presenter = LoginPresenter(displaying: displayThreadWrapper)
        let interactor = LoginInteractor(
            worker: worker,
            router: routerThreadWrapper,
            presenter: presenter
        )
        let controller = LoginViewController(
            interactor: interactor,
            keyboardManager: KeyboardManagerImpl()
        )
        displayThreadWrapper.displaying = controller
        routerThreadWrapper.router = router
        return controller
    }
}
