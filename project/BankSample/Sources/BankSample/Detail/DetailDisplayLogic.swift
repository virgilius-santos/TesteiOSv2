import Foundation

public protocol DetailDisplayLogic: AnyObject {
    func startLoading()
    func stopLoading()
    func displayUserInfo(viewModel: Detail.ViewModel)
    func displayDetail(_ detailList: [Detail.StatementViewModel])
}
