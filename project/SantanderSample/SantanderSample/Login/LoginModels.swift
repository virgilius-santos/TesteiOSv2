import UIKit

enum Login {
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
    
    struct UserAccount: Decodable, Equatable {
        let id: String
        let name: String
        let bankAccount: String
        let agency: String
        let balance: Double
    }
    
    struct ErrorViewModel {
        let error: String?
    }
    
    struct LastUserViewModel {
        let password: String?
        let user: String?
    }
}
