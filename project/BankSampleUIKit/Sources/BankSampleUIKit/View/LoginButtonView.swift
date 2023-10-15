import UIKit

final class LoginButtonView: UIView {
    var action: (() -> Void)?
    
    lazy var loginButton: UIButton = {
        $0.setTitle("Login", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .blueApp
        $0.cornerRadius = 8
        $0.addTarget(self, action: #selector(_Action), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            loginButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
        backgroundColor = .clear
    }
    
    @objc private func _Action() {
        action?()
    }
}
