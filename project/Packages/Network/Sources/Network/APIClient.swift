import Foundation

public protocol APIClient {
    func request<Response: Decodable>(_ request: APIRequest) async -> Result<Response, APIError>
}
