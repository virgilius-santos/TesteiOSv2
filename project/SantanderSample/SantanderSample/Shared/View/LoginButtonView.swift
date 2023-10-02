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
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
        backgroundColor = .clear
    }
    
    @objc private func _Action() {
        action?()
    }
}
