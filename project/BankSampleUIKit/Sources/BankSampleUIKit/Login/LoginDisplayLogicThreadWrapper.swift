import Foundation
import FoundationUtils

final class LoginDisplayLogicThreadWrapper: LoginDisplayLogic {
    weak var displaying: LoginDisplayLogic?
    
    func startLoading() {
        displaying.executeInMainThread { displaying in
            displaying.startLoading()
        }
    }
    
    func stopLoading() {
        displaying.executeInMainThread { displaying in
            displaying.stopLoading()
        }
    }
    
    func displayError(viewModel: Login.ErrorViewModel) {
        displaying.executeInMainThread { displaying in
            displaying.displayError(viewModel: viewModel)
        }
    }
    
    func displayLastUser(viewModel: Login.LastUserViewModel) {
        displaying.executeInMainThread { displaying in
            displaying.displayLastUser(viewModel: viewModel)
        }
    }
}
