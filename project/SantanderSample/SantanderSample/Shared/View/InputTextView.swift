import UIKit

final class InputTextView: UIView {
    lazy var textField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.grayPlaceholderApp]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
        backgroundColor = .clear
        borderColor = .grayApp
        borderWidth = 2
    }
    
    func setPlaceholder(_ string: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: attributes
        )
    }

}
