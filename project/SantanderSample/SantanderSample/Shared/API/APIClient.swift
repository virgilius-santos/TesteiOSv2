import Foundation

protocol APIClient {
    func request<Response: Decodable>(_ request: APIRequest, completion: @escaping (Result<Response, APIError>)->())
}

enum APIError: Error, Equatable {
    case invalidBody
    case invalid(url: String)
    case requestError(NSError, Data?, URLResponse?)
    case dataNil(URLResponse?)
    case decodeError(Data, URLResponse?)
}
