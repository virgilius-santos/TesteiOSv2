import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath, instance: T.Type) -> T? {
        
        let cellIdentifier = String(describing: instance.self)
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? T
        
        return cell
    }
    
    func registerWithNib<T: UICollectionViewCell>(instance: T.Type) {
        let cellIdentifier = String(describing: instance.self)
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
