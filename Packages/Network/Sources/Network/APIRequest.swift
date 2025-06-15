import Foundation

public struct APIRequest: Equatable {
    public enum HttpMethod: String, Equatable {
        case post = "POST"
        case get = "GET"
    }
    
    public let headers: [String: String]
    public let url: String
    public let body: Data?
    public let httpMethod: HttpMethod
    
    public init(headers: [String: String] = .init(), url: String, body: Data? = nil, httpMethod: HttpMethod = .get) {
        self.headers = headers
        self.url = url
        self.body = body
        self.httpMethod = httpMethod
    }
}
