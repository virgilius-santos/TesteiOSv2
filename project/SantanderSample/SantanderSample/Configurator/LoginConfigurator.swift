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
        LoginBuider.initialize(router: router, client: client, keychain: keychain, displayProvider: { interactor in
            LoginViewController(
                interactor: interactor,
                keyboardManager: KeyboardManagerImpl()
            )
        })
    }
}
