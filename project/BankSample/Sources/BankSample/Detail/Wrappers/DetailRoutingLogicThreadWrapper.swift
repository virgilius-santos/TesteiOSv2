import Foundation
import FoundationUtils

final class DetailRoutingLogicThreadWrapper: DetailRoutingLogic {
    weak var router: DetailRoutingLogic?
    
    init(router: DetailRoutingLogic? = nil) {
        self.router = router
    }
    
    func routeToLogin() {
        router.executeInMainThread { router in
            router.routeToLogin()
        }
    }
}
