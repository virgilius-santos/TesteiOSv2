import UIKit
import Network
import KeyChain

public enum LoginBuider<Display: LoginDisplayLogic> {
    public typealias DisplayProvider = (LoginBusinessLogic) -> Display
    
    static func initialize(
        router: LoginRoutingLogic,
        client: APIClient,
        keychain: KeychainManager,
        displayProvider: DisplayProvider
    ) -> Display {
        let displayThreadWrapper = LoginDisplayLogicThreadWrapper()
        let routerThreadWrapper = LoginRoutingLogicThreadWrapper()
        let worker = LoginWorker(client: client, keychain: keychain)
        let presenter = LoginPresenter(displaying: displayThreadWrapper)
        let interactor = LoginInteractor(
            worker: worker,
            router: routerThreadWrapper,
            presenter: presenter
        )
        let display = displayProvider(interactor)
        displayThreadWrapper.displaying = display
        routerThreadWrapper.router = router
        return display
    }
}
