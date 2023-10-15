import UIKit
import Network

final class DetailWorker {
    let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func getDetails(request: Detail.Request, completion: @escaping (Result<Detail.Response, APIError>) -> ()) {
        let apiRequest = APIRequest(url: "v1/login/1")
        client.request(apiRequest) { (result: Result<Detail.Response, APIError>) in
            completion(result)
        }
    }
}
