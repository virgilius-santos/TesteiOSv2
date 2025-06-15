import NetworkImpl
import UIKit
import BankSample
import BankSampleUIKit
import BankSampleSwiftUI
import SwiftUI

protocol HasLoginRoutingLogic {
    var loginRouter: LoginRoutingLogic { get }
}

protocol HasDetailRoutingLogic {
    var detailRouter: DetailRoutingLogic { get }
}

final class APPRouter: NSObject, ObservableObject {
    typealias Dependencies = HasUIKitFactory & HasSwiftUIFactory
    
    let dependencies: Dependencies
    let window: UIWindow
    let navigation = UINavigationController()
        
    lazy var factory: SceneFactory = dependencies.uiKitFactory
    
    init(window: UIWindow, dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
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
        let details = factory.makeDetail(user: user)
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
        factory = dependencies.uiKitFactory
        navigation.show(factory.makeLogin(), sender: nil)
    }
    
    func showBakingWithSwiftUI() {
        factory = dependencies.swiftUIFactory
        navigation.show(factory.makeLogin(), sender: nil)
    }
}

extension Login.UserAccount {
    var detailRequest: Detail.Request {
        .init(userId: id, name: name, bankAccount: bankAccount, agency: agency, balance: balance)
    }
}
