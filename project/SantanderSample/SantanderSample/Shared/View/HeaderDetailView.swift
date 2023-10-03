import UIKit

extension HeaderDetailView {
    func set(title: String, info: String) {
        isAccessibilityElement = true
        accessibilityLabel = title + " " + info
        self.title.label.text = title
        self.info.label.text = info
    }
}

final class HeaderDetailView: UIView {
    lazy var title: TitleDetailView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(TitleDetailView())
    
    lazy var info: InfoDetailView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(InfoDetailView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(title)
        addSubview(info)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            info.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            info.leadingAnchor.constraint(equalTo: leadingAnchor),
            info.trailingAnchor.constraint(equalTo: trailingAnchor),
            info.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        backgroundColor = .clear
    }
}
