import Foundation

public final class LoginRoutingLogicThreadWrapper: LoginRoutingLogic {
    public weak var router: LoginRoutingLogic?
    
    public init(router: LoginRoutingLogic? = nil) {
        self.router = router
    }
    
    public func routeToDetails(user: Login.UserAccount) {
        router.executeInMainThread { router in
            router.routeToDetails(user: user)
        }
    }
}
