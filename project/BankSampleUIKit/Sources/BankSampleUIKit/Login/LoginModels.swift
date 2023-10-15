import UIKit

public enum Login {
    struct Request: Encodable, Equatable {
        let user: String
        let password: String
        
        init(user: String?, password: String?) {
            self.user = user ?? ""
            self.password = password ?? ""
        }
    }
    
    struct LoginSave {
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
    
    struct ErrorViewModel {
        let error: String?
    }
    
    struct LastUserViewModel {
        let password: String?
        let user: String?
    }
}
