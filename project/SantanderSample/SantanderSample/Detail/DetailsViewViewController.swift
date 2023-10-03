import UIKit

protocol DetailDisplayLogic: AnyObject {
    func startLoading()
    func stopLoading()
    func displayUserInfo(viewModel: Detail.ViewModel)
    func displayDetail(_ detailList: [Detail.StatementViewModel])
}

final class DetailsViewViewController: ViewControllerBase<DetailBusinessLogic, DetailView> {
    var detailList: [Detail.StatementViewModel] = []
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.exit.action = { [interactor] in
            interactor.logout()
        }
        rootView.statements.list.dataSource = self
        rootView.statements.list.registerWithNib(instance: DetailCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.getDetails()
    }
    
    func exitAction() {
        interactor.logout()
    }
}

extension DetailsViewViewController: DetailDisplayLogic {
    func startLoading() {
        rootView.statements.lock()
    }
    
    func stopLoading() {
        rootView.statements.unlock()
    }
    
    func displayUserInfo(viewModel: Detail.ViewModel) {
        rootView.name.label.text = viewModel.name
        rootView.account.set(title: "Conta", info: viewModel.account ?? "")
        rootView.balance.set(title: "Saldo", info: viewModel.balance ?? "")
    }
    
    func displayDetail(_ detailList: [Detail.StatementViewModel]) {
        self.detailList = detailList
        rootView.statements.reload()
    }
}

extension DetailsViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellForItemAt: indexPath, instance: DetailCell.self)
        cell.setup(viewModel: detailList[indexPath.row])
        return cell
    }
}
