import XCTest
@testable import BankSample

final class DetailLogicMock: DetailDisplayLogic, DetailRoutingLogic {
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
    
    lazy var routeToLoginImpl: () -> Void = { [file, line] in
        XCTFail("routeToLoginImpl not implemented", file: file, line: line)
    }
    func routeToLogin() {
        routeToLoginImpl()
    }
    
    lazy var displayUserInfoImpl: (_ viewModel: Detail.ViewModel) -> Void = { [file, line] _ in
        XCTFail("displayUserInfoImpl not implemented", file: file, line: line)
    }
    func displayUserInfo(viewModel: Detail.ViewModel) {
        displayUserInfoImpl(viewModel)
    }
    
    lazy var displayDetailImpl: (_ detailList: [Detail.StatementViewModel]) -> Void = { [file, line] _ in
        XCTFail("displayDetailImpl not implemented", file: file, line: line)
    }
    func displayDetail(_ detailList: [Detail.StatementViewModel]) {
        displayDetailImpl(detailList)
    }
}
