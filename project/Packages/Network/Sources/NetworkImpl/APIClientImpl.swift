import Foundation
import FoundationUtils
import Network

public final class APIClientImpl: NSObject, APIClient {
    let baseApi = "https://65198632818c4e98ac6078a8.mockapi.io/api/"
    
    var task: URLSessionTask?
    
    public init(task: URLSessionDataTask? = nil) {
        self.task = task
        super.init()
    }
    
    public func request<Response: Decodable>(_ request: APIRequest) async -> Result<Response, APIError> {
        guard let requestMapped = request.mapped else {
            return .failure(.invalid(url: request.url))
        }
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = request.headers
        let session = URLSession(configuration: config)
        
        do {
            async let (data, _) = try session.data(for: requestMapped)
            let object = try await Response.decoder(data: data)
            return .success(object)
        } catch {
            return .failure(.requestError(error as NSError, nil, nil))
        }
    }
    
    deinit {
        task?.cancel()
    }
}

extension APIClientImpl: URLSessionTaskDelegate {
    public func urlSession(_ session: URLSession, didCreateTask task: URLSessionTask) {
        self.task = task
    }
}

extension APIRequest {
    var mapped: URLRequest? {
        let baseApi = "https://65198632818c4e98ac6078a8.mockapi.io/api/"
        guard let url = URL(string: baseApi + url) else {
            return nil
        }        
        var mutableRequest = URLRequest(url: url)
        mutableRequest.httpBody = body
        mutableRequest.httpMethod = httpMethod.rawValue
        return mutableRequest
    }
}
