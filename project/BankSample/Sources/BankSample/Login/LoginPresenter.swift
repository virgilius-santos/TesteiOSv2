import UIKit

public final class LoginPresenter {
    let displaying: LoginDisplayLogic
    
    public init(displaying: LoginDisplayLogic) {
        self.displaying = displaying
    }
    
    func startLoading() {
        displaying.startLoading()
    }
    
    func stopLoading() {
        displaying.stopLoading()
    }
    
    func present(error: Error) {
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
    
    func present(lastLogin: Login.LoginSave) {
        let viewModel = Login.LastUserViewModel(
            password: lastLogin.password,
            user: lastLogin.user
        )
        displaying.displayLastUser(viewModel: viewModel)
    }
}
