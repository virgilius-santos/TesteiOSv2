import Foundation

public protocol APIClient {
    typealias Completion<R> = (Result<R, APIError>) -> Void
    func request<Response: Decodable>(_ request: APIRequest, completion: @escaping Completion<Response>)
}
