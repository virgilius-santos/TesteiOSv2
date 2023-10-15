import UIKit

final class DetailCell: UITableViewCell {
    lazy var card: UIView = {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    lazy var paymentLabel: UILabel = {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var dateLabel: UILabel = {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var infoLabel: UILabel = {
        $0.font = .preferredFont(forTextStyle: .body)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var priceLabel: UILabel = {
        $0.font = .preferredFont(forTextStyle: .body)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    func configureCell() {
        configureLayout()
        configureStyle()
    }
    
    func configureLayout() {
        contentView.addSubview(card)
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: 8),
        ])

        card.addSubview(paymentLabel)
        NSLayoutConstraint.activate([
            paymentLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 8),
            paymentLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 8)
        ])
        
        card.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: paymentLabel.leadingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -8)
        ])
        
        card.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: paymentLabel.topAnchor),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: paymentLabel.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -8)
        ])

        card.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: infoLabel.topAnchor),
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: infoLabel.trailingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: infoLabel.bottomAnchor),
        ])
    }
    
    func configureStyle() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        card.cornerRadius = 8
    }
}
