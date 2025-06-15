@testable import SantanderSample
import XCTest
import KeyChain

final class KeychainManagerMock: KeychainManager {
    let file: StaticString
    let line: UInt
    
    init(file: StaticString, line: UInt) {
        self.file = file
        self.line = line
    }
    
    lazy var saveImpl: (_ value: String, _ type: DestinationType) -> Bool = { [file, line] _, _ in
        XCTFail("saveImpl not implemented", file: file, line: line)
        return false
    }
    func save(_ value: String, type: DestinationType) -> Bool {
        saveImpl(value, type)
    }
    
    lazy var getTypeImpl: (_ type: DestinationType) -> String? = { [file, line] _ in
        XCTFail("getTypeImpl not implemented", file: file, line: line)
        return nil
    }
    func get(type: DestinationType) -> String? {
        getTypeImpl(type)
    }
    
    lazy var removeTypeImpl: (_ type: DestinationType) -> Bool = { [file, line] _ in
        XCTFail("removeTypeImpl not implemented", file: file, line: line)
        return false
    }
    func remove(type: DestinationType) -> Bool {
        removeTypeImpl(type)
    }
}
