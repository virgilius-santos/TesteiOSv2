import UIKit

final class StatementsView: UIView {
    lazy var collection: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = .init(width: 342, height: 80)
        ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = .zero

        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        backgroundColor = .clear
    }
}
