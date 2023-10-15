import UIKit
import Network
import BankSample
import BankSampleUIKit

final class DetailConfigurator {
    let client: APIClient
    let user: Login.UserAccount
    let router: DetailRoutingLogic
    
    init(router: DetailRoutingLogic, user: Login.UserAccount, client: APIClient) {
        self.client = client
        self.user = user
        self.router = router
    }
    
    func build() -> UIViewController {
        DetailBuider.initialize(request: user.detailRequest, router: router, client: client, displayProvider: DetailsViewViewController.init(interactor:))
    }
}

extension Login.UserAccount {
    var detailRequest: Detail.Request {
        .init(userId: id, name: name, bankAccount: bankAccount, agency: agency, balance: balance)
    }
}
