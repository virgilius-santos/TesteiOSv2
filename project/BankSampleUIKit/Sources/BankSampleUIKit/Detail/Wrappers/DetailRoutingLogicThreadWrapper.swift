import Foundation
import FoundationUtils

final class DetailRoutingLogicThreadWrapper: DetailRoutingLogic {
    weak var router: DetailRoutingLogic?
    
    func routeToLogin() {
        router.executeInMainThread { router in
            router.routeToLogin()
        }
    }
}
