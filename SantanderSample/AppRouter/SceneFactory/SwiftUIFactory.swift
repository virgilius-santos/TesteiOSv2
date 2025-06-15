import UIKit
import BankSample
import NetworkImpl
import BankSampleSwiftUI
import SwiftUI

protocol HasSwiftUIFactory {
    var swiftUIFactory: SceneFactory { get }
}

final class SwiftUIFactory: SceneFactory {
    typealias Dependencies = HasLoginRoutingLogic & HasDetailRoutingLogic
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeLogin() -> UIViewController {
        let viewModel = LoginBuider.initialize(
            router: dependencies.loginRouter,
            client: APIClientImpl(),
            keychain: KeychainManagerImpl(),
            displayProvider: { interactor in
                LoginView.ViewModel(interactor: interactor)
            }
        )
        let view = LoginView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func makeDetail(user: Login.UserAccount) -> UIViewController {
        let viewModel = DetailBuider.initialize(
            request: user.detailRequest,
            router: dependencies.detailRouter,
            client: APIClientImpl(),
            displayProvider: { interactor in
                DetailView.ViewModel(interactor: interactor)
            }
        )
        let view = DetailView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
