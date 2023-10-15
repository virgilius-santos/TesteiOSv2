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
        let controller = LoginBuider.initialize(router: self, client: APIClientImpl(), keychain: KeychainManagerImpl(), displayProvider: { interactor in
            LoginViewController(
                interactor: interactor,
                keyboardManager: KeyboardManagerImpl()
            )
        })
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
        let details = DetailBuider.initialize(request: user.detailRequest, router: self, client: APIClientImpl(), displayProvider: DetailsViewViewController.init(interactor:))
        navigation.present(details, animated: true, completion: nil)
    }
}

extension APPRouter: DetailRoutingLogic {
    func routeToLogin() {
        dismiss()
    }
}

extension Login.UserAccount {
    var detailRequest: Detail.Request {
        .init(userId: id, name: name, bankAccount: bankAccount, agency: agency, balance: balance)
    }
}
