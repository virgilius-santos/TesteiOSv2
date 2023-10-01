import Foundation

final class APIClientImpl: APIClient {
    let baseApi = "https://65198632818c4e98ac6078a8.mockapi.io/api/"
    
    var task: URLSessionDataTask?
    
    func request<Response: Decodable>(_ request: APIRequest, completion: @escaping (Result<Response, APIError>)->()) {
        guard let url = URL(string: baseApi + request.url) else {
            completion(.failure(.invalid(url: request.url)))
            return
        }
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = request.headers
        let session = URLSession(configuration: config)
        
        let mutableRequest = NSMutableURLRequest(url: url)
        mutableRequest.httpBody = request.body
        mutableRequest.httpMethod = request.httpMethod.rawValue

        let task = session.dataTask(with: mutableRequest as URLRequest) { [weak self] (data, response, error) in
            guard self != nil else { return }
            if let error {
                completion(.failure(.requestError(error as NSError, data, response)))
                return
            }
            guard let data = data else {
                completion(.failure(.dataNil(response)))
                return
            }

            do {
                let object = try Response.decoder(data: data)
                completion(.success(object))
            } catch {
                completion(.failure(.decodeError(data, response)))
            }
        }
        
        self.task = task
        task.resume()
    }
    
    deinit {
        task?.cancel()
    }
}
