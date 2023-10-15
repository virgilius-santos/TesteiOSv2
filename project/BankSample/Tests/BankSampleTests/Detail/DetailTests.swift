import XCTest
@testable import BankSample
import Network

extension Detail.Request {
    static func fixture() -> Self {
        .init(
            userId: "id",
            name: "name",
            bankAccount: "bankAccount",
            agency: "agency",
            balance: 12
        )
    }
}

extension Detail.Response {
    static func fixture() -> Self {
        .init(statementList: [.fixture()])
    }
}

extension Detail.Statement {
    static func fixture() -> Self {
        .init(title: "title", desc: "desc", date: "date", value: 12)
    }
}

extension Detail.StatementViewModel {
    static func fixture() -> Self {
        .init(title: "title", desc: "desc", date: "15/10/2023", value: "$12,000.00")
    }
}

private extension DetailTests {
    typealias Sut = DetailBusinessLogic
    
    final class Fields {
        let file: StaticString
        let line: UInt
        
        var events = [String]()
        var completionMock: (() -> Void)?
        
        lazy var detailMock = DetailLogicMock(file: file, line: line)
        lazy var clientMock = APIClientMock<Detail.Response>(file: file, line: line)
        
        init(file: StaticString, line: UInt) {
            self.file = file
            self.line = line
        }
        
        func configureDisplayLogic(withMessageError message: String? = nil, file: StaticString = #filePath, line: UInt = #line) {
            detailMock.routeToLoginImpl = { [weak self] in
                self?.events.append("routeToLoginImpl called")
            }
            detailMock.startLoadingImpl = { [weak self] in
                self?.events.append("startLoadingImpl called")
            }
            detailMock.stopLoadingImpl = { [weak self] in
                self?.events.append("stopLoadingImpl called")
            }
            detailMock.displayUserInfoImpl = { [weak self] in
                XCTAssertEqual($0, .init(name: "name", account: "bankAccount / ag.enc-y", balance: "$12,000.00"), "invalid user info sended", file: file, line: line)
                self?.events.append("displayUserInfoImpl called")
            }
            detailMock.displayDetailImpl = { [weak self] in
                XCTAssertEqual($0, [.fixture()], "invalid user info sended", file: file, line: line)
                self?.events.append("displayDetailImpl called")
            }
        }
        
        func configureRequest(toCompleteWith result: Result<Detail.Response, APIError> = .failure(.invalidBody), file: StaticString = #filePath, line: UInt = #line) throws {
            clientMock.requestImpl = { [weak self] request, completion in
                XCTAssertEqual(request, .init(url: "v1/login/1"), "invalid body received", file: file, line: line)
                self?.completionMock = {
                    completion?(result)
                }
                self?.events.append("requestImpl called")
            }
        }
    }
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (Sut, Fields)  {
        let fields = Fields(file: file, line: line)
        var sut: Sut!
        
        let _ = DetailBuider.initialize(
            request: .fixture(),
            router: fields.detailMock,
            client: fields.clientMock,
            displayProvider: {
                sut = $0
                return fields.detailMock
            }
        )
        
        XCTAssertNotNil(sut, "sut not instanciated", file: file, line: line)
        
        checkMemoryLeak(object: sut as? DetailInteractor)
        checkMemoryLeak(object: fields.detailMock)
        checkMemoryLeak(object: fields.clientMock)
        
        return (sut, fields)
    }
}

final class DetailTests: XCTestCase {
    func testGetDetail_ShouldDisplayInitialInfo_AndMakeRequest() throws {
        let (sut, fields) = makeSut()
        try fields.configureRequest()
        fields.configureDisplayLogic()
        
        sut.getDetails()
        
        XCTAssertEqual(fields.events, ["displayUserInfoImpl called", "startLoadingImpl called", "requestImpl called"])
    }
    
    func testGetDetail_WhenReceiveSuccess_AndShouldDisplay() throws {
        let (sut, fields) = makeSut()
        try fields.configureRequest(toCompleteWith: .success(.fixture()))
        fields.configureDisplayLogic()
        
        sut.getDetails()
        
        XCTAssertEqual(fields.events, ["displayUserInfoImpl called", "startLoadingImpl called", "requestImpl called"])
        fields.events = []
        
        fields.completionMock?()
        
        XCTAssertEqual(fields.events, ["stopLoadingImpl called", "displayDetailImpl called"])
    }
}
