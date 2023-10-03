import UIKit

final class TitleDetailView: UIView {
    lazy var label: UILabel = {
        $0.textColor = .white
        $0.accessibilityTraits = .header
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .preferredFont(forTextStyle: .subheadline)
        $0.adjustsFontForContentSizeCategory = true
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        backgroundColor = .clear
    }
}
