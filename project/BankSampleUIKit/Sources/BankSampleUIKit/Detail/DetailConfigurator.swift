import UIKit
import Network

public final class DetailConfigurator {
    let client: APIClient
    let user: Login.UserAccount
    let router: DetailRoutingLogic
    
    public init(router: DetailRoutingLogic, user: Login.UserAccount, client: APIClient) {
        self.client = client
        self.user = user
        self.router = router
    }
    
    public func build() -> UIViewController {
        let displayThreadWrapper = DetailDisplayLogicThreadWrapper()
        let routerThreadWrapper = DetailRoutingLogicThreadWrapper()
        let worker = DetailWorker(client: client)
        let presenter = DetailPresenter(displaying: displayThreadWrapper)
        let interactor = DetailInteractor(
            worker: worker,
            router: routerThreadWrapper,
            presenter: presenter,
            request: user.detailRequest
        )
        let controller = DetailsViewViewController(interactor: interactor)
        displayThreadWrapper.displaying = controller
        routerThreadWrapper.router = router
        return controller
    }
}

extension Login.UserAccount {
    var detailRequest: Detail.Request {
        .init(userId: id, name: name, bankAccount: bankAccount, agency: agency, balance: balance)
    }
}
