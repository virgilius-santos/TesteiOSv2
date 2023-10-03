import UIKit

final class ExitButtonView: UIView {
    var action: (() -> Void)?
    
    lazy var exitButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "logout 2"), for: .normal)
        $0.accessibilityLabel = "Exit"
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
        addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: topAnchor),
            exitButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            exitButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            exitButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 44),
            exitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        backgroundColor = .clear
    }

    @objc private func _Action() {
        action?()
    }
}
