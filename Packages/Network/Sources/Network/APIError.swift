import Foundation

public enum APIError: Error, Equatable {
    case invalidBody
    case invalid(url: String)
    case requestError(NSError, Data?, URLResponse?)
    case dataNil(URLResponse?)
    case decodeError(NSError, Data, URLResponse?)
}
