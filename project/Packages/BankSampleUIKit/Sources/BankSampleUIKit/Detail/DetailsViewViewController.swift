import UIKit
import UIKitComponents
import BankSample

public final class DetailsViewViewController: ViewControllerBase<DetailBusinessLogic, DetailView> {
    var detailList: [Detail.StatementViewModel] = []

    // MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        rootView.exit.action = { [interactor] in
            interactor.logout()
        }
        rootView.statements.list.dataSource = self
        rootView.statements.list.registerWithNib(instance: DetailCell.self)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.getDetails()
    }

    func exitAction() {
        interactor.logout()
    }
}

extension DetailsViewViewController: DetailDisplayLogic {
    public func startLoading() {
        rootView.statements.lock()
    }

    public func stopLoading() {
        rootView.statements.unlock()
    }

    public func displayUserInfo(viewModel: Detail.ViewModel) {
        rootView.name.label.text = viewModel.name
        rootView.account.set(title: "Conta", info: viewModel.account ?? "")
        rootView.balance.set(title: "Saldo", info: viewModel.balance ?? "")
    }

    public func displayDetail(_ detailList: [Detail.StatementViewModel]) {
        self.detailList = detailList
        rootView.statements.reload()
    }
}

extension DetailsViewViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellForItemAt: indexPath, instance: DetailCell.self)
        cell.setup(viewModel: detailList[indexPath.row])
        return cell
    }
}

extension DetailCell {
    func setup(viewModel: Detail.StatementViewModel) {
        dateLabel.text = viewModel.date
        infoLabel.text = viewModel.desc
        paymentLabel.text = viewModel.title
        priceLabel.text = viewModel.value
    }
}
