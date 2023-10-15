import UIKit

public protocol LoginPresentationLogic {
    func startLoading()
    func stopLoading()
    func present(error: Error)
    func present(lastLogin: Login.LoginSave)
}

public final class LoginPresenter {
    let displaying: LoginDisplayLogic
    
    public init(displaying: LoginDisplayLogic) {
        self.displaying = displaying
    }
}

extension LoginPresenter: LoginPresentationLogic {
    public func startLoading() {
        displaying.startLoading()
    }
    
    public func stopLoading() {
        displaying.stopLoading()
    }
    
    public func present(error: Error) {
        let message: String = {
            switch error {
                
            case Login.Error.id:
                return "Erro de ID"
                
            case Login.Error.password:
                return "Erro de password"
                
            default:
                return "Login Invalido, tente novamente"
            }
        }()
        let viewModel = Login.ErrorViewModel(error: message)
        displaying.displayError(viewModel: viewModel)
    }
    
    public func present(lastLogin: Login.LoginSave) {
        let viewModel = Login.LastUserViewModel(
            password: lastLogin.password,
            user: lastLogin.user
        )
        displaying.displayLastUser(viewModel: viewModel)
    }
}
