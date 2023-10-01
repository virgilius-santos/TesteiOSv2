import Foundation

struct APIRequest: Equatable {
    enum HttpMethod: String, Equatable {
        case post = "POST"
        case get = "GET"
    }
    var headers = [String: String]()
    var url: String
    var body: Data?
    var httpMethod: HttpMethod = .get
}
