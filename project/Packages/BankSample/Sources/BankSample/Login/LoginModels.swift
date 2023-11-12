import UIKit

public enum Login {
    public struct Request: Encodable, Equatable {
        let user: String
        let password: String
        
        public init(user: String?, password: String?) {
            self.user = user ?? ""
            self.password = password ?? ""
        }
    }
    
    public struct LoginSave {
        let user: String?
        let password: String?
    }
    
    enum Error: Swift.Error {
        case id
        case password
    }
    
    public struct UserAccount: Decodable, Equatable {
        public let id: String
        public let name: String
        public let bankAccount: String
        public let agency: String
        public let balance: Double
    }
    
    public struct ErrorViewModel: Equatable {
        public let error: String?
    }
    
    public struct LastUserViewModel: Equatable {
        public let password: String?
        public let user: String?
    }
}
