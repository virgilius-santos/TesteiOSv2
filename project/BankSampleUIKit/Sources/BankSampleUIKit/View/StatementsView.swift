import UIKit

final class StatementsView: UIView {
    lazy var list: UITableView = {
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(list)
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            list.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            list.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            list.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        backgroundColor = .clear
    }
    
    func reload() {
        list.reloadData()
    }
}
