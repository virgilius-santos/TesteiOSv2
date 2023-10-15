@testable import KeyChainImpl
@testable import KeyChain
import SwiftKeychainWrapper
import XCTest

private extension KeychainTests {
    typealias Sut = KeychainManager
    
    func makeSut() -> Sut {
        let wrapper = KeychainWrapper(serviceName: UUID().uuidString)
        let sut = KeychainManagerImpl(wrapper: wrapper)
        return sut
    }
}

final class KeychainTests: XCTestCase {
    func testUser() {
        let sut = makeSut()
        
        // initiale should be empty
        XCTAssertNil(sut.get(type: .user))
        
        // and when remove should respond false
        XCTAssertFalse(sut.remove(type: .user))
        
        // and when add user should return true
        let newUser = "dolly"
        XCTAssertTrue(sut.save(newUser, type: .user))
        
        // and when get user should return newUser
        XCTAssertEqual(sut.get(type: .user), newUser)
        
        // and when remove should respond true
        XCTAssertTrue(sut.remove(type: .user))

        // and when get should be empty
        XCTAssertNil(sut.get(type: .user))
    }
    
    func testPassword() {
        let sut = makeSut()
        
        // initiale should be empty
        XCTAssertNil(sut.get(type: .password))
        
        // and when remove should respond false
        XCTAssertFalse(sut.remove(type: .password))
        
        // and when add password should return true
        let newPassword = "dolly"
        XCTAssertTrue(sut.save(newPassword, type: .password))
        
        // and when get password should return newpassword
        XCTAssertEqual(sut.get(type: .password), newPassword)
        
        // and when remove should respond true
        XCTAssertTrue(sut.remove(type: .password))

        // and when get should be empty
        XCTAssertNil(sut.get(type: .password))
    }
}
