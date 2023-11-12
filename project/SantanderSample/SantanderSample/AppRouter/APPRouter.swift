import NetworkImpl
import UIKit
import BankSample
import BankSampleUIKit

final class APPRouter: NSObject {
    let window: UIWindow
    let navigation = UINavigationController()
    
    var makeLoginViewController: UIViewController {
        LoginBuider.initialize(router: self, client: APIClientImpl(), keychain: KeychainManagerImpl(), displayProvider: { interactor in
            LoginViewController(
                interactor: interactor,
                keyboardManager: KeyboardManagerImpl()
            )
        })
    }
    
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
        navigation.delegate = self
        window.makeKeyAndVisible()
    }
    
    func dismiss() {
        navigation.dismiss(animated: true)
    }
}

extension APPRouter: LoginRoutingLogic {
    // MARK: Routing
    func routeToDetails(user: Login.UserAccount) {
        let details = DetailBuider.initialize(request: user.detailRequest, router: self, client: APIClientImpl(), displayProvider: DetailsViewViewController.init(interactor:))
        details.modalPresentationStyle = .overFullScreen
        navigation.showDetailViewController(details, sender: nil)
    }
}

extension APPRouter: DetailRoutingLogic {
    func routeToLogin() {
        dismiss()
    }
}

extension APPRouter: UINavigationControllerDelegate {}

extension Login.UserAccount {
    var detailRequest: Detail.Request {
        .init(userId: id, name: name, bankAccount: bankAccount, agency: agency, balance: balance)
    }
}
