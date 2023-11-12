import Foundation

public protocol LoginRoutingLogic: AnyObject {
    func routeToDetails(user: Login.UserAccount)
}

public protocol LoginBusinessLogic {
    func auth(request: Login.Request)
    func getLastUser()
}

final class LoginInteractor {
    let worker: LoginWorker
    let router: LoginRoutingLogic
    let presenter: LoginPresenter
    
    init(worker: LoginWorker, router: LoginRoutingLogic, presenter: LoginPresenter) {
        self.presenter = presenter
        self.worker = worker
        self.router = router
    }
}

extension LoginInteractor: LoginBusinessLogic {
    private func isValidId(request: Login.Request) -> Bool {
        worker.validateId(request.user)
    }
    
    private func isValidPassword(request: Login.Request) -> Bool {
        worker.validatePassword(request.password)
    }
    
    func auth(request: Login.Request) {
        guard isValidId(request: request) else {
            presenter.present(error: Login.Error.id)
            return
        }
        guard isValidPassword(request: request) else {
            presenter.present(error: Login.Error.password)
            return
        }
        
        presenter.startLoading()
        worker.login(request) { [weak self] (result) in
            guard let self else { return }
            self.presenter.stopLoading()
            switch result{
            case .success(let userAccount):
                self.router.routeToDetails(user: userAccount)
                
            case .failure(let error):
                self.presenter.present(error: error)
            }
        }
    }
    
    func getLastUser() {
        let lastLogin = worker.getLastLogin()
        presenter.present(lastLogin: lastLogin)
    }
}
