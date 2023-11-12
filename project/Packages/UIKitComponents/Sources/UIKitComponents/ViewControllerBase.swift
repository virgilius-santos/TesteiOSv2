import UIKit

open class ViewControllerBase<Interactor, View: UIView>: UIViewController {
    public let interactor: Interactor
    public private(set) lazy var rootView = View()
    
    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override public func loadView() {
        view = rootView
    }
}
