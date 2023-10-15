import Foundation
import SwiftKeychainWrapper
import KeyChain

final class KeychainManagerImpl: KeychainManager {
    private var wrapper: KeychainWrapper
    
    convenience init() {
        self.init(wrapper: KeychainWrapper.standard)
    }
    
    init(wrapper: KeychainWrapper) {
        self.wrapper = wrapper
    }
    
    /// Add a string value to keychain
    @discardableResult
    func save(_ value: String, type: DestinationType) -> Bool {
        let saveSuccessful: Bool = wrapper.set(value, forKey: type.rawValue, isSynchronizable: true)
        return saveSuccessful
    }
    
    /// Retrieve a string value from keychain:
    func get(type: DestinationType) -> String? {
        let retrievedString: String? = wrapper.string(forKey: type.rawValue, isSynchronizable: true)
        return retrievedString
    }
    
    ///Remove a string value from keychain:
    func remove(type: DestinationType) -> Bool {
        let removeSuccessful: Bool = wrapper.removeObject(forKey: type.rawValue, isSynchronizable: true)
        return removeSuccessful
    }
}
