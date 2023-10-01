import Foundation
import SwiftKeychainWrapper

enum DestinationType: String {
    case user, password
}

protocol KeychainManager {
    @discardableResult
    func save(_ value: String, type: DestinationType) -> Bool
    func get(type: DestinationType) -> String?
    @discardableResult
    func remove(type: DestinationType) -> Bool
}

final class KeychainManagerImpl: KeychainManager {
    private var wrapper: KeychainWrapper
    
    init(wrapper: KeychainWrapper = KeychainWrapper.standard) {
        self.wrapper = wrapper
    }
    
    /// Add a string value to keychain
    @discardableResult
    func save(_ value: String, type: DestinationType) -> Bool {
        let saveSuccessful: Bool = wrapper.set(value, forKey: type.rawValue)
        return saveSuccessful
    }
    
    /// Retrieve a string value from keychain:
    func get(type: DestinationType) -> String? {
        let retrievedString: String? = wrapper.string(forKey: type.rawValue)
        return retrievedString
    }
    
    ///Remove a string value from keychain:
    func remove(type: DestinationType) -> Bool {
        let removeSuccessful: Bool = wrapper.removeObject(forKey: type.rawValue)
        return removeSuccessful
    }
}
