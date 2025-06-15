import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appRouter: APPRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Instantiate a window.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appRouter = APPRouter(window: window)
        
        // Instantiate the root view controller with dependencies injected by the container.
        appRouter.start()
        
        self.window = window
        self.appRouter = appRouter
        
        return true
    }
}
