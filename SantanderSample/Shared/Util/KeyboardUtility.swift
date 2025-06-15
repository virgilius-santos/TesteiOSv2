import UIKit
import UIKitComponents
import IQKeyboardManagerSwift

final class KeyboardManagerImpl: KeyboardManager {
    static var shared = KeyboardManagerImpl()
    
    init() {}
    
    var enable: Bool = false {
        didSet(newValue) {
            IQKeyboardManager.shared.enable = newValue
        }
    }
    
}
