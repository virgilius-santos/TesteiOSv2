import UIKit

public final class LoginView: UIView {
    lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    lazy var logoView: LogoView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(LogoView())
    
    lazy var idView: InputTextView = {
        $0.setPlaceholder("User")
        $0.textField.returnKeyType = .next
        $0.textField.keyboardType = .numberPad
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(InputTextView())
    
    lazy var passwordView: InputTextView = {
        $0.setPlaceholder("Password")
        $0.textField.isSecureTextEntry = true
        $0.textField.returnKeyType = .done
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(InputTextView())
    
    lazy var loginButtonView: LoginButtonView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(LoginButtonView())
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 300),
        ])
        contentView.addSubview(logoView)
        contentView.addSubview(idView)
        contentView.addSubview(passwordView)
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 125),
            logoView.heightAnchor.constraint(equalToConstant: 70),
            idView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            idView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            idView.heightAnchor.constraint(equalToConstant: 50),
            passwordView.topAnchor.constraint(equalTo: idView.bottomAnchor, constant: 24),
            passwordView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            passwordView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            passwordView.heightAnchor.constraint(equalToConstant: 50),
            passwordView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        addSubview(loginButtonView)
        NSLayoutConstraint.activate([
            loginButtonView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 50),
            loginButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        backgroundColor = .white
    }
}
