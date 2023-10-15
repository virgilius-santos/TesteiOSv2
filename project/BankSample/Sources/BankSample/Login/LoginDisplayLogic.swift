import Foundation

public protocol LoginDisplayLogic: AnyObject {
    func startLoading()
    func stopLoading()
    func displayError(viewModel: Login.ErrorViewModel)
    func displayLastUser(viewModel: Login.LastUserViewModel)
}
