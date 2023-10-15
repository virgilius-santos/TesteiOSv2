import Foundation
import SwiftKeychainWrapper
import KeyChain

public final class KeychainManagerImpl: KeychainManager {
    private var wrapper: KeychainWrapper
    
    public init(wrapper: KeychainWrapper = KeychainWrapper.standard) {
        self.wrapper = wrapper
    }
    
    /// Add a string value to keychain
    @discardableResult
    public func save(_ value: String, type: DestinationType) -> Bool {
        let saveSuccessful: Bool = wrapper.set(value, forKey: type.rawValue)
        return saveSuccessful
    }
    
    /// Retrieve a string value from keychain:
    public func get(type: DestinationType) -> String? {
        let retrievedString: String? = wrapper.string(forKey: type.rawValue)
        return retrievedString
    }
    
    ///Remove a string value from keychain:
    public func remove(type: DestinationType) -> Bool {
        let removeSuccessful: Bool = wrapper.removeObject(forKey: type.rawValue)
        return removeSuccessful
    }
}
