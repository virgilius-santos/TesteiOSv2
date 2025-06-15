import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appRouter: APPRouter?
    
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Instantiate a window.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let container = DependenciesContainer(window: window)
        let appRouter = container.appRouter
        
        // Instantiate the root view controller with dependencies injected by the container.
        appRouter.start()
        
        self.window = window
        self.appRouter = appRouter
        
        return true
    }
}
