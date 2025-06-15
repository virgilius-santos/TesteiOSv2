import UIKit
import Network

public protocol DetailRoutingLogic: AnyObject {
    func routeToLogin()
}

public protocol DetailBusinessLogic: AnyObject {
    func getDetails()
    func logout()
}

final class DetailInteractor {
    let presenter: DetailPresenter
    let worker: DetailWorker
    let router: DetailRoutingLogic
    let request: Detail.Request
    
    private var loadingTask: Task<Void, Never>?
    
    init(
        worker: DetailWorker,
        router: DetailRoutingLogic,
        presenter: DetailPresenter,
        request: Detail.Request
    ) {
        
        self.presenter = presenter
        self.worker = worker
        self.router = router
        self.request = request
    }
    
    deinit {
        loadingTask?.cancel()
    }
}

extension DetailInteractor: DetailBusinessLogic {
    func logout() {
        router.routeToLogin()
    }
    
    func getDetails() {
        let response = Detail.UserViewModel(
            id: request.userId,
            name: request.name,
            bankAccount: request.bankAccount,
            agency: request.agency,
            balance: request.balance
        )
        presenter.presentUserInfo(response: response)
        presenter.startLoading()
        loadingTask = Task { [weak self, worker, request] in
            let result = await worker.getDetails(request: request)
            self?.presenter.stopLoading()
            switch result {
            case .success(let resp):
                self?.presenter.present(response: resp.statementList)
            case .failure(let error):
                let error = Detail.Error(code: 0, message: error.localizedDescription)
                self?.presenter.present(error: error)
            }
        }
    }
}
