import NetworkImpl
import UIKit
import BankSample
import BankSampleUIKit
import KeyChainImpl

final class APPRouter: NSObject {
    let window: UIWindow
    let navigation = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let controller = LoginConfigurator(router: self, client: APIClientImpl(), keychain: KeychainManagerImpl()).build()
        navigation.viewControllers = [controller]
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    func dismiss() {
        navigation.dismiss(animated: true, completion: nil)
    }
}

extension APPRouter: LoginRoutingLogic {
    // MARK: Routing
    func routeToDetails(user: Login.UserAccount) {
        let details = DetailConfigurator(router: self, user: user, client: APIClientImpl()).build()
        navigation.present(details, animated: true, completion: nil)
    }
}

extension APPRouter: DetailRoutingLogic {
    func routeToLogin() {
        dismiss()
    }
}
