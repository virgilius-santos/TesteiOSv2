import NetworkImpl
import UIKit
import BankSample
import BankSampleUIKit
import SwiftUI

final class APPRouter: NSObject, ObservableObject {
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
        let view = AppSelectionView(routing: self)
        let controller = UIHostingController(rootView: view)
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

extension APPRouter: AppSelectionRouting {
    func showBakingWithUIKit() {
        navigation.show(makeLoginViewController, sender: nil)
    }
    
    func showBakingWithSwiftUI() {
        // TODO: Next Task
    }
}

extension Login.UserAccount {
    var detailRequest: Detail.Request {
        .init(userId: id, name: name, bankAccount: bankAccount, agency: agency, balance: balance)
    }
}
