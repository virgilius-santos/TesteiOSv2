@testable import SantanderSample
import XCTest

final class APIClientMock: APIClient {
    let file: StaticString
    let line: UInt
    
    init(file: StaticString, line: UInt) {
        self.file = file
        self.line = line
    }
    
    lazy var requestImpl: (
        _ request: APIRequest,
        _ completion: @escaping (Any) -> ()
    ) -> Void = { [file, line] _, _ in
        XCTFail("requestImpl not implemented", file: file, line: line)
    }
    func request<Response>(
        _ request: APIRequest,
        completion: @escaping (Result<Response, APIError>) -> ()
    ) where Response : Decodable {
        requestImpl(request, { [file, line] result in
            if let result = result as? Result<Response, APIError> {
                completion(result)
            } else {
                XCTFail("Invalid Result", file: file, line: line)
            }
        })
    }
}
