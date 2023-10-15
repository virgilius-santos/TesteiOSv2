import Foundation

public protocol APIClient {
    func request<Response: Decodable>(_ request: APIRequest, completion: @escaping (Result<Response, APIError>)->())
}
