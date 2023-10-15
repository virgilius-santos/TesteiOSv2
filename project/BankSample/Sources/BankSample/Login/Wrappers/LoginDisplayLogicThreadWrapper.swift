import Foundation
import FoundationUtils

public final class LoginDisplayLogicThreadWrapper: LoginDisplayLogic {
    public weak var displaying: LoginDisplayLogic?
    
    public init(displaying: LoginDisplayLogic? = nil) {
        self.displaying = displaying
    }
    
    public func startLoading() {
        displaying.executeInMainThread { displaying in
            displaying.startLoading()
        }
    }
    
    public func stopLoading() {
        displaying.executeInMainThread { displaying in
            displaying.stopLoading()
        }
    }
    
    public func displayError(viewModel: Login.ErrorViewModel) {
        displaying.executeInMainThread { displaying in
            displaying.displayError(viewModel: viewModel)
        }
    }
    
    public func displayLastUser(viewModel: Login.LastUserViewModel) {
        displaying.executeInMainThread { displaying in
            displaying.displayLastUser(viewModel: viewModel)
        }
    }
}
