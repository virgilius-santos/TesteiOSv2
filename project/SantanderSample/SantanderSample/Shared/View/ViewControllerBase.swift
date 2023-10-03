import UIKit

class ViewControllerBase<Interactor, View: UIView>: UIViewController {
    let interactor: Interactor
    private(set) lazy var rootView = View()
    
    init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func loadView() {
        view = rootView
    }
}
