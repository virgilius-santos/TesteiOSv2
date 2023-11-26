import UIKit
import BankSample

protocol SceneFactory {
    func makeLogin() -> UIViewController
    func makeDetail(user: Login.UserAccount) -> UIViewController
}
