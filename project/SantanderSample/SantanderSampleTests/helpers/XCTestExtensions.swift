import XCTest

extension XCTestCase {
    func checkMemoryLeak(object: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak object] in
            XCTAssertNil(object, "verify memory leak for \(type(of: object))", file: file, line: line)
        }
    }
}
