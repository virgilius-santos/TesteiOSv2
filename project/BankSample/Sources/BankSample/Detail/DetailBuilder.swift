import UIKit
import Network

public enum DetailBuider<Display: DetailDisplayLogic> {
    public typealias DisplayProvider = (DetailBusinessLogic) -> Display
    
    public static func initialize(
        request: Detail.Request,
        router: DetailRoutingLogic,
        client: APIClient,
        displayProvider: DisplayProvider
    ) -> Display {
        let displayThreadWrapper = DetailDisplayLogicThreadWrapper()
        let routerThreadWrapper = DetailRoutingLogicThreadWrapper()
        let worker = DetailWorker(client: client)
        let presenter = DetailPresenter(displaying: displayThreadWrapper)
        let interactor = DetailInteractor(
            worker: worker,
            router: routerThreadWrapper,
            presenter: presenter,
            request: request
        )
        let display = displayProvider(interactor)
        displayThreadWrapper.displaying = display
        routerThreadWrapper.router = router
        return display
    }
}
