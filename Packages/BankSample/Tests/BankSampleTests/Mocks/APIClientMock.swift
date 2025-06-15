import XCTest
@testable import BankSample
import Network

final class APIClientMock<Mock: Decodable>: APIClient {
    let file: StaticString
    let line: UInt
    
    init(file: StaticString, line: UInt) {
        self.file = file
        self.line = line
    }
    
    lazy var requestImpl: (_ request: APIRequest, _ completion: Completion<Mock>?) -> Void = { [file, line] _, _ in
        XCTFail("requestImpl not implemented", file: file, line: line)
    }
    func request<R: Decodable>(_ request: APIRequest, completion: @escaping Completion<R>) {
        requestImpl(request, completion as? Completion<Mock>)
    }
}
