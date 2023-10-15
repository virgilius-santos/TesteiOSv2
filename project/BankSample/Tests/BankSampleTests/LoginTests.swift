import XCTest
@testable import BankSample
import Network

extension Login.UserAccount {
    static func fixture() -> Self {
        .init(
            id: "id",
            name: "name",
            bankAccount: "bankAccount",
            agency: "agency",
            balance: 12
        )
    }
}
private extension LoginTests {
    typealias Sut = LoginBusinessLogic
    
    final class Fields {
        let file: StaticString
        let line: UInt
        
        var events = [String]()
        var completionMock: (() -> Void)?
        
        lazy var loginMock = LoginLogicMock(file: file, line: line)
        lazy var clientMock = APIClientMock<Login.UserAccount>(file: file, line: line)
        lazy var keychainMock = KeychainManagerMock(file: file, line: line)
        
        init(file: StaticString, line: UInt) {
            self.file = file
            self.line = line
        }
        
        func configureLoginDisplay(withMessageError message: String? = nil, file: StaticString = #filePath, line: UInt = #line) {
            loginMock.displayErrorImpl = { [weak self] in
                XCTAssertEqual($0, Login.ErrorViewModel(error: message), "invalid error", file: file, line: line)
                self?.events.append("displayErrorImpl called")
            }
            loginMock.startLoadingImpl = { [weak self] in
                self?.events.append("startLoadingImpl called")
            }
            loginMock.stopLoadingImpl = { [weak self] in
                self?.events.append("stopLoadingImpl called")
            }
            loginMock.routeToDetailsImpl = { [weak self] in
                XCTAssertEqual($0, .fixture(), "invalid model sended", file: file, line: line)
                self?.events.append("routeToDetailsImpl called")
            }
            loginMock.displayLastUserImpl = { [weak self] in
                XCTAssertEqual($0, .init(password: "value", user: "value"), "invalid last user sended", file: file, line: line)
                self?.events.append("displayLastUserImpl called")
            }
        }
        
        func configureRequest(toCompleteWith result: Result<Login.UserAccount, APIError> = .failure(.invalidBody), file: StaticString = #filePath, line: UInt = #line) throws {
            let body = try JSONEncoder().encode(Login.Request(user: "user@gmail.com", password: "P1!asder"))
            clientMock.requestImpl = { [weak self] request, completion in
                XCTAssertEqual(request, .init(url: "v1/login", body: body, httpMethod: .post), "invalid body received", file: file, line: line)
                self?.completionMock = {
                    completion?(result)
                }
                self?.events.append("requestImpl called")
            }
        }
        
        func configureKeychain() {
            keychainMock.getImpl = { [weak self] in
                self?.events.append("saveImpl called with \($0)")
                return "value"
            }
            keychainMock.saveImpl = { [weak self] in
                self?.events.append("saveImpl called with \($1): \($0)")
                return true
            }
        }
    }
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (Sut, Fields)  {
        let fields = Fields(file: file, line: line)
        var sut: Sut!
        
        let _ = LoginBuider.initialize(
            router: fields.loginMock,
            client: fields.clientMock,
            keychain: fields.keychainMock,
            displayProvider: {
                sut = $0
                return fields.loginMock
            }
        )
        
        XCTAssertNotNil(sut, "sut not instanciated", file: file, line: line)
        
        checkMemoryLeak(object: sut as? LoginInteractor)
        checkMemoryLeak(object: fields.loginMock)
        checkMemoryLeak(object: fields.clientMock)
        checkMemoryLeak(object: fields.keychainMock)
        
        return (sut, fields)
    }
}

final class LoginTests: XCTestCase {
    func testLogin_WithNilUser_ShouldDisplayError() {
        let (sut, fields) = makeSut()
        fields.configureLoginDisplay(withMessageError: "Erro de ID")
        
        sut.auth(request: .init(user: nil, password: nil))
        
        XCTAssertEqual(fields.events, ["displayErrorImpl called"])
    }
    
    func testLogin_WithNilPassword_ShouldDisplayError() {
        let (sut, fields) = makeSut()
        fields.configureLoginDisplay(withMessageError: "Erro de password")
        
        sut.auth(request: .init(user: "user@gmail.com", password: nil))
        
        XCTAssertEqual(fields.events, ["displayErrorImpl called"])
    }
    
    func testLogin_WithValidData_ShouldRequestData() throws {
        let (sut, fields) = makeSut()
        fields.configureLoginDisplay()
        try fields.configureRequest()
        
        sut.auth(request: .init(user: "user@gmail.com", password: "P1!asder"))
        
        XCTAssertEqual(fields.events, ["startLoadingImpl called", "requestImpl called"])
    }
    
    func testLogin_WhenRequestCompletesWithSuccess_ShouldRouteToDetail() throws {
        let (sut, fields) = makeSut()
        fields.configureLoginDisplay()
        try fields.configureRequest(toCompleteWith: .success(.fixture()))
        fields.configureKeychain()
        
        sut.auth(request: .init(user: "user@gmail.com", password: "P1!asder"))
        
        XCTAssertEqual(fields.events, ["startLoadingImpl called", "requestImpl called"])
        fields.events = []
        
        fields.completionMock?()
        
        XCTAssertEqual(fields.events, [
            "saveImpl called with user: user@gmail.com",
            "saveImpl called with password: P1!asder",
            "stopLoadingImpl called",
            "routeToDetailsImpl called"
        ])
    }
    
    func testLogin_WhenRequestCompletesWithFail_ShouldRouteToDetail() throws {
        let (sut, fields) = makeSut()
        fields.configureLoginDisplay(withMessageError: "Login Invalido, tente novamente")
        try fields.configureRequest(toCompleteWith: .failure(.invalidBody))
        
        sut.auth(request: .init(user: "user@gmail.com", password: "P1!asder"))
        
        XCTAssertEqual(fields.events, ["startLoadingImpl called", "requestImpl called"])
        fields.events = []
        
        fields.completionMock?()
        
        XCTAssertEqual(fields.events, [
            "stopLoadingImpl called",
            "displayErrorImpl called"
        ])
    }
    
    
    func testLogin_ShouldDisplayDataStored() throws {
        let (sut, fields) = makeSut()
        fields.configureLoginDisplay()
        fields.configureKeychain()
        
        sut.getLastUser()
        
        XCTAssertEqual(fields.events, [
            "saveImpl called with user",
            "saveImpl called with password",
            "displayLastUserImpl called"
        ])
    }
}
