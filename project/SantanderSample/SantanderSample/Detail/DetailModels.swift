import UIKit

enum Detail {
    struct Request {
        let userId: String
        let name: String
        let bankAccount: String
        let agency: String
        let balance: Double
    }
    
    struct Response: Decodable {
        let statementList: [Statement]
    }
    
    struct UserViewModel {
        let id: String
        let name: String
        let bankAccount: String
        let agency: String
        let balance: Double
    }
    
    struct Error {
        let code: Int
        let message: String
    }
    
    struct ViewModel {
        let name: String?
        let account: String?
        let balance: String?
    }
    
    struct StatementViewModel {
        let title: String?
        let desc: String?
        let date: String?
        let value: String?
    }
    
    struct Statement: Codable {
        let title: String
        let desc: String
        let date: String
        let value: Double
    }
}
