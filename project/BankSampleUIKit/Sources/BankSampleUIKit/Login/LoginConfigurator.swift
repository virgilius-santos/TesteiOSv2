import UIKit
import Network
import KeyChain

public final class LoginConfigurator {
    let client: APIClient
    let router: LoginRoutingLogic
    let keychain: KeychainManager
    
    public init(
        router: LoginRoutingLogic,
        client: APIClient,
        keychain: KeychainManager
    ) {
        self.router = router
        self.client = client
        self.keychain = keychain
    }
    
    public func build() -> UIViewController {
        let displayThreadWrapper = LoginDisplayLogicThreadWrapper()
        let routerThreadWrapper = LoginRoutingLogicThreadWrapper()
        let worker = LoginWorker(client: client, keychain: keychain)
        let presenter = LoginPresenter(displaying: displayThreadWrapper)
        let interactor = LoginInteractor(
            worker: worker,
            router: routerThreadWrapper,
            presenter: presenter
        )
        let controller = LoginViewController(interactor: interactor)
        displayThreadWrapper.displaying = controller
        routerThreadWrapper.router = router
        return controller
    }
}
