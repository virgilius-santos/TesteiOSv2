import XCTest
@testable import BankSample

final class LoginLogicMock: LoginDisplayLogic, LoginRoutingLogic {
    let file: StaticString
    let line: UInt
    
    init(file: StaticString, line: UInt) {
        self.file = file
        self.line = line
    }
    
    lazy var startLoadingImpl: () -> Void = { [file, line] in
        XCTFail("startLoadingImpl not implemented", file: file, line: line)
    }
    func startLoading() {
        startLoadingImpl()
    }
    
    lazy var stopLoadingImpl: () -> Void = { [file, line] in
        XCTFail("stopLoadingImpl not implemented", file: file, line: line)
    }
    func stopLoading() {
        stopLoadingImpl()
    }
    
    lazy var displayErrorImpl: (_ viewModel: Login.ErrorViewModel) -> Void = { [file, line] _ in
        XCTFail("displayErrorImpl not implemented", file: file, line: line)
    }
    func displayError(viewModel: Login.ErrorViewModel) {
        displayErrorImpl(viewModel)
    }
    
    lazy var displayLastUserImpl: (_ viewModel: Login.LastUserViewModel) -> Void = { [file, line] _ in
        XCTFail("displayLastUserImpl not implemented", file: file, line: line)
    }
    func displayLastUser(viewModel: Login.LastUserViewModel) {
        displayLastUserImpl(viewModel)
    }
        
    lazy var routeToDetailsImpl: (_ user: Login.UserAccount) -> Void = { [file, line] _ in
        XCTFail("routeToDetailsImpl not implemented", file: file, line: line)
    }
    func routeToDetails(user: Login.UserAccount) {
        routeToDetailsImpl(user)
    }
}
