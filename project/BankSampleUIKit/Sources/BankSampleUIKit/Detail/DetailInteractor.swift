import UIKit
import Network

public protocol DetailRoutingLogic: AnyObject {
    func routeToLogin()
}

protocol DetailBusinessLogic: AnyObject {
    func getDetails()
    func logout()
}

final class DetailInteractor {
    let presenter: DetailPresentationLogic
    let worker: DetailWorker
    let router: DetailRoutingLogic
    let request: Detail.Request
    
    init(
        worker: DetailWorker,
        router: DetailRoutingLogic,
        presenter: DetailPresentationLogic,
        request: Detail.Request
    ) {
        
        self.presenter = presenter
        self.worker = worker
        self.router = router
        self.request = request
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
        worker.getDetails(request: request, completion: { [weak self] (result: Result<Detail.Response, APIError>) in
            guard let self else { return }
            self.presenter.stopLoading()
            switch result {
            case .success(let resp):
                self.presenter.present(response: resp.statementList)

            case .failure(let error):
                let error = Detail.Error(code: 0, message: error.localizedDescription)
                self.presenter.present(error: error)
            }
        })
    }
}
