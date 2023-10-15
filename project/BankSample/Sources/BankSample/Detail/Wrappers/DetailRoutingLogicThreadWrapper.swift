import Foundation
import FoundationUtils

public final class DetailRoutingLogicThreadWrapper: DetailRoutingLogic {
    public weak var router: DetailRoutingLogic?
    
    public init(router: DetailRoutingLogic? = nil) {
        self.router = router
    }
    
    public func routeToLogin() {
        router.executeInMainThread { router in
            router.routeToLogin()
        }
    }
}
