import UIKit

protocol DetailPresentationLogic {
    func startLoading()
    func stopLoading()
    func present(response: [Detail.Statement])
    func presentUserInfo(response: Detail.UserViewModel)
    func present(error: Detail.Error)
}

final class DetailPresenter {
    let displaying: DetailDisplayLogic
    
    init(displaying: DetailDisplayLogic) {
        self.displaying = displaying
    }
}

extension DetailPresenter: DetailPresentationLogic {
    func startLoading() {
        displaying.startLoading()
    }
    
    func stopLoading() {
        displaying.stopLoading()
    }
    
    func present(error: Detail.Error) {
        // TODO: definir layout de erro
    }
    
    func presentUserInfo(response: Detail.UserViewModel) {
        let mStr = NSMutableString(string: response.agency)
        mStr.insert("-", at: response.agency.count-1)
        mStr.insert(".", at: 2)
        let viewModel = Detail.ViewModel(
            name: response.name,
            account: "\(response.bankAccount) / \(mStr)",
            balance: response.balance.currency
        )
        displaying.displayUserInfo(viewModel: viewModel)
    }
    
    func present(response: [Detail.Statement]) {
        let detailList = response
            .map {
                Detail.StatementViewModel(
                    title: $0.title,
                    desc: $0.desc,
                    date: $0.date.toDate(format: .apiDate).toString(format: .displayDate),
                    value: $0.value.currency
                )
        }
        displaying.displayDetail(detailList)
    }
}
