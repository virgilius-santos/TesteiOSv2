import Foundation

final class LoginRoutingLogicThreadWrapper: LoginRoutingLogic {
    weak var router: LoginRoutingLogic?
    
    func routeToDetails(user: Login.UserAccount) {
        router.executeInMainThread { router in
            router.routeToDetails(user: user)
        }
    }
}
