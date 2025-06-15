import NetworkImpl
import UIKit
import BankSample
import BankSampleUIKit
import BankSampleSwiftUI
import SwiftUI

typealias Dependencies = HasLoginRoutingLogic &
HasDetailRoutingLogic &
HasUIKitFactory &
HasSwiftUIFactory

final class DependenciesContainer: Dependencies {
    lazy var appRouter = APPRouter(window: window, dependencies: self)
    var loginRouter: LoginRoutingLogic { appRouter }
    var detailRouter: DetailRoutingLogic { appRouter }
    
    var uiKitFactory: SceneFactory { UIKitFactory(dependencies: self) }
    var swiftUIFactory: SceneFactory { SwiftUIFactory(dependencies: self) }
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}
