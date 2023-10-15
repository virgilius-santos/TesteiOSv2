@testable import BankSample
import XCTest
import Network

private extension LoginWorkerTests {
    typealias Sut = LoginWorker
    
    final class Fields {
        let clientMock: APIClientMock<Login.UserAccount>
        let keychainMock: KeychainManagerMock
        
        var events = [String]()
        var completionMock: (() -> Void)? = nil
        
        init(file: StaticString, line: UInt) {
            clientMock = .init(file: file, line: line)
            keychainMock = .init(file: file, line: line)
        }
        
        func configureClient(
            requestExpected: APIRequest,
            resultToSend: Result<Login.UserAccount, APIError>,
            file: StaticString = #filePath, line: UInt = #line
        ) {
            clientMock.requestImpl = { [weak self] request, completion in
                XCTAssertEqual(request, requestExpected, file: file, line: line)
                self?.completionMock = { completion?(resultToSend) }
                self?.events.append("client request called")
            }
        }
        
        func configureKeychainToReceiveEvents() {
            keychainMock.saveImpl = { [weak self] value, type in
                self?.events.append("keychain save value: \(value) for type: \(type)")
                return true
            }
        }
        
        func simulateResultAsync() {
            completionMock?()
        }
    }
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: Sut, fields: Fields) {
        let fields = Fields(file: file, line: line)
        let sut = LoginWorker(
            client: fields.clientMock,
            keychain: fields.keychainMock
        )
        checkMemoryLeak(object: sut, file: file, line: line)
        checkMemoryLeak(object: fields.clientMock, file: file, line: line)
        checkMemoryLeak(object: fields.keychainMock, file: file, line: line)
        return (sut, fields)
    }
}

final class LoginWorkerTests: XCTestCase {
    func test_validatePassword_rules() {
        let sut = makeSut().sut
        XCTAssertTrue(sut.validatePassword("T@1"))
        XCTAssertTrue(sut.validatePassword("a@T"))
        XCTAssertFalse(sut.validatePassword("fail"))
        XCTAssertFalse(sut.validatePassword("Fail"))
        XCTAssertFalse(sut.validatePassword("f0ail"))
        XCTAssertFalse(sut.validatePassword("fai@l"))
        XCTAssertFalse(sut.validatePassword("@l"))
        XCTAssertFalse(sut.validatePassword(""))
        XCTAssertFalse(sut.validatePassword(nil))
    }
    
    func test_validateId_rules() {
        let sut = makeSut().sut
        XCTAssertTrue(sut.validateId("admin@admin.com"))
        XCTAssertTrue(sut.validateId("333.777.666-66"))
        XCTAssertTrue(sut.validateId("33333333339"))
        XCTAssertTrue(sut.validateId("admin@admin.com.ki"))
        XCTAssertFalse(sut.validateId("7777uuuuu"))
        XCTAssertFalse(sut.validateId("awewe@l"))
        XCTAssertFalse(sut.validateId("373333333339"))
        XCTAssertFalse(sut.validateId("@lrrttrert"))
        XCTAssertFalse(sut.validateId(""))
        XCTAssertFalse(sut.validateId(nil))
    }
    
    func testLogin_shouldReturnUserAccount() throws {
        let request = Login.Request(
            user: "validUser@gmail.com",
            password: "V@lidPassw0rd"
        )
        let userReceived = Login.UserAccount(
            id: "id",
            name: "name",
            bankAccount: "bankAccount",
            agency: "agency",
            balance: 50
        )
        let requestExpected = APIRequest(url: "v1/login", body: try JSONEncoder().encode(request), httpMethod: .post)
        let resultExpected =  Result<Login.UserAccount, APIError>.success(userReceived)
        let (sut, fields) = makeSut()
        fields.configureClient(requestExpected: requestExpected, resultToSend: resultExpected)
        fields.configureKeychainToReceiveEvents()
        
        sut.login(request) { [weak fields] result in
            XCTAssertEqual(result, resultExpected)
            fields?.events.append("login result received")
        }
        
        XCTAssertEqual(fields.events, ["client request called"])
        
        fields.simulateResultAsync()
        
        XCTAssertEqual(fields.events, [
            "client request called",
            "keychain save value: validUser@gmail.com for type: user",
            "keychain save value: V@lidPassw0rd for type: password",
            "login result received"
        ])
    }
}
