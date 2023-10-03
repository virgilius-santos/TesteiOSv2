import UIKit

final class DetailView: UIView {
    lazy var content: UIView = {
        $0.backgroundColor = .blueApp
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    lazy var name: TitleDetailView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(TitleDetailView())
    
    lazy var exit: ExitButtonView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ExitButtonView())
    
    lazy var account: HeaderDetailView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(HeaderDetailView())
    
    lazy var balance: HeaderDetailView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(HeaderDetailView())
    
    lazy var recents: TitleDetailView = {
        $0.label.text = "Recents"
        $0.label.textColor = .blueApp
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(TitleDetailView())
    
    lazy var statements: StatementsView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(StatementsView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            content.leadingAnchor.constraint(equalTo: leadingAnchor),
            content.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        content.addSubview(name)
        content.addSubview(exit)
        content.addSubview(account)
        content.addSubview(balance)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(greaterThanOrEqualTo: content.topAnchor),
            name.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            
            exit.topAnchor.constraint(equalTo: content.topAnchor, constant: 8),
            exit.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 8),
            exit.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -8),
            exit.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            
            account.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 24),
            account.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            account.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            
            balance.topAnchor.constraint(equalTo: account.bottomAnchor, constant: 24),
            balance.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            balance.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            balance.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -24)
        ])
        
        addSubview(recents)
        NSLayoutConstraint.activate([
            recents.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 8),
            recents.leadingAnchor.constraint(equalTo: leadingAnchor),
            recents.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(statements)
        NSLayoutConstraint.activate([
            statements.topAnchor.constraint(equalTo: recents.bottomAnchor, constant: 8),
            statements.leadingAnchor.constraint(equalTo: leadingAnchor),
            statements.trailingAnchor.constraint(equalTo: trailingAnchor),
            statements.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
        
        backgroundColor = .white
    }
}
