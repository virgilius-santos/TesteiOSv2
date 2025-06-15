import UIKit
import Network

final class DetailWorker {
    let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func getDetails(request: Detail.Request) async -> Result<Detail.Response, APIError> {
        let apiRequest = APIRequest(url: "v1/login/1")
        let result: Result<Detail.Response, APIError> = await client.request(apiRequest)
        return result
    }
}
