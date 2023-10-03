import UIKit

protocol DetailDisplayLogic: AnyObject {
    func startLoading()
    func stopLoading()
    func displayUserInfo(viewModel: Detail.ViewModel)
    func displayDetail(_ detailList: [Detail.StatementViewModel])
}

final class DetailsViewViewController: UIViewController {
    let interactor: DetailBusinessLogic
    var detailList: [Detail.StatementViewModel] = []
    
    init(interactor: DetailBusinessLogic) {
        self.interactor = interactor
        
        super.init(nibName: String(describing: DetailsViewViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.getDetails()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var exitView: ExitButtonView! {
        didSet {
            exitView.action = { [weak self] in
                self?.exitAction()
            }
        }
    }
    
    @IBOutlet weak var nameView: InfoDetailView! {
        didSet{
            nameView.infoLabel.text = ""
        }
    }
    
    @IBOutlet weak var accountTitleView: TitleDetailView! {
        didSet {
            accountTitleView.titleLabel.text = "Conta"
        }
    }
    @IBOutlet weak var accountInfoView: InfoDetailView! {
        didSet{
            accountInfoView.infoLabel.text = ""
        }
    }
    
    @IBOutlet weak var balanceTitleView: TitleDetailView! {
        didSet {
            balanceTitleView.titleLabel.text = "Saldo"
        }
    }
    
    @IBOutlet weak var balnceInfoView: InfoDetailView!{
        didSet{
            balnceInfoView.infoLabel.text = ""
        }
    }
    
    @IBOutlet weak var detailsView: UIView!
    
    @IBOutlet weak var entriesCollectionView: UICollectionView! {
        didSet {
            entriesCollectionView.delegate = self
            entriesCollectionView.dataSource = self
            entriesCollectionView.registerWithNib(instance: DetailCell.self)
        }
    }
    
    @objc func exitAction() {
        interactor.logout()
    }
}

extension DetailsViewViewController: DetailDisplayLogic {
    func startLoading() {
        detailsView.lock()
    }
    
    func stopLoading() {
        detailsView.unlock()
    }
    
    func displayUserInfo(viewModel: Detail.ViewModel) {
        nameView.infoLabel.text = viewModel.name
        accountInfoView.infoLabel.text = viewModel.account
        balnceInfoView.infoLabel.text = viewModel.balance
    }
    
    func displayDetail(_ detailList: [Detail.StatementViewModel]) {
        self.detailList = detailList
        entriesCollectionView.reloadData()
    }
}

extension DetailsViewViewController: UICollectionViewDelegate {}

extension DetailsViewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellForItemAt: indexPath, instance: DetailCell.self)
        cell?.setup(viewModel: detailList[safeIndex: indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}
