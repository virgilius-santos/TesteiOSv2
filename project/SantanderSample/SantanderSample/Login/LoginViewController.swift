import UIKit

protocol LoginDisplayLogic: AnyObject {
    func startLoading()
    func stopLoading()
    func displayError(viewModel: Login.ErrorViewModel)
    func displayLastUser(viewModel: Login.LastUserViewModel)
}

final class LoginViewController: UIViewController {
    let interactor: LoginBusinessLogic

    init(interactor: LoginBusinessLogic) {
        self.interactor = interactor
        
        super.init(nibName: String(describing: LoginViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        KeyboardManager.shared.enable = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.getLastUser()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        KeyboardManager.shared.enable = false
    }
    
    // MARK: Do something

    @IBOutlet weak var logoView: LogoView!
    
    @IBOutlet weak var idView: InputTextView! {
        didSet {
            idView.setPlaceholder("User")
            idView.textField.delegate = self
            idView.textField.returnKeyType = .next
            idView.textField.keyboardType = .numberPad
        }
    }
    
    @IBOutlet weak var passwordView: InputTextView! {
        didSet {
            passwordView.setPlaceholder("Password")
            passwordView.textField.isSecureTextEntry = true
            passwordView.textField.delegate = self
            passwordView.textField.returnKeyType = .done
        }
    }
    
    @IBOutlet weak var loginButtonView: LoginButtonView! {
        didSet {
            let button = loginButtonView.loginButton
            button?.addTarget(self,
                              action: #selector(loginAction),
                              for: .touchUpInside)
        }
    }
    
    @objc func loginAction() {
        let request = Login.Request(user: idView.textField.text, password: passwordView.textField.text)
        interactor.auth(request: request)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            passwordView.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension LoginViewController: LoginDisplayLogic {
    func startLoading() {
        view.lock()
    }
    
    func stopLoading() {
        view.unlock()
    }
    
    func displayLastUser(viewModel: Login.LastUserViewModel) {
        idView.textField.text = viewModel.user
        passwordView.textField.text = viewModel.password
    }
    
    func displayError(viewModel: Login.ErrorViewModel) {
        showAlert(withMessage: viewModel.error!)
    }
    
    private func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
