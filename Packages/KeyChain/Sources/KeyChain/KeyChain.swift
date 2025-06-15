
public enum DestinationType: String {
    case user, password
}

public protocol KeychainManager {
    @discardableResult
    func save(_ value: String, type: DestinationType) -> Bool
    
    func get(type: DestinationType) -> String?
    
    @discardableResult
    func remove(type: DestinationType) -> Bool
}
