import UIKit

public extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(cellForItemAt indexPath: IndexPath, instance: T.Type) -> T {
        let cellIdentifier = String(describing: instance.self)
        let cell = dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? T
        return cell ?? T()
    }
    
    func registerWithNib<T: UITableViewCell>(instance: T.Type) {
        let cellIdentifier = String(describing: instance.self)
        register(T.self, forCellReuseIdentifier: cellIdentifier)
    }
}
