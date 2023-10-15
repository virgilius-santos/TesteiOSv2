import UIKit

public enum Detail {
    public struct Request {
        let userId: String
        let name: String
        let bankAccount: String
        let agency: String
        let balance: Double
        
        public init(userId: String, name: String, bankAccount: String, agency: String, balance: Double) {
            self.userId = userId
            self.name = name
            self.bankAccount = bankAccount
            self.agency = agency
            self.balance = balance
        }
    }
    
    struct Response: Decodable {
        let statementList: [Statement]
    }
    
    public struct UserViewModel {
        let id: String
        let name: String
        let bankAccount: String
        let agency: String
        let balance: Double
    }
    
    public struct Error {
        let code: Int
        let message: String
    }
    
    public struct ViewModel {
        public let name: String?
        public let account: String?
        public let balance: String?
    }
    
    public struct StatementViewModel {
        public let title: String?
        public let desc: String?
        public let date: String?
        public let value: String?
    }
    
    public struct Statement: Codable {
        let title: String
        let desc: String
        let date: String
        let value: Double
    }
}
