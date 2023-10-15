import UIKit
import UIKitComponents
import BankSample

public final class LoginViewController: ViewControllerBase<LoginBusinessLogic, LoginView> {
    // MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureIdView()
        configurePasswordView()
        configureLoginAction()
        
//        KeyboardManager.shared.enable = true
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.getLastUser()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        KeyboardManager.shared.enable = false
    }
    
    private func configureIdView() {
        rootView.idView.setPlaceholder("User")
        rootView.idView.textField.delegate = self
        rootView.idView.textField.returnKeyType = .next
        rootView.idView.textField.keyboardType = .numberPad
    }
    
    private func configurePasswordView() {
        rootView.passwordView.setPlaceholder("Password")
        rootView.passwordView.textField.isSecureTextEntry = true
        rootView.passwordView.textField.delegate = self
        rootView.passwordView.textField.returnKeyType = .done
    }
        
    private func configureLoginAction() {
        rootView.loginButtonView.action = { [weak self] in
            guard let self else { return }
            let request = Login.Request(
                user: self.rootView.idView.getText(),
                password: self.rootView.passwordView.getText()
            )
            self.interactor.auth(request: request)
        }
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            rootView.passwordView.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension LoginViewController: LoginDisplayLogic {
    public func startLoading() {
        view.lock()
    }
    
    public func stopLoading() {
        view.unlock()
    }
    
    public func displayLastUser(viewModel: Login.LastUserViewModel) {
        rootView.idView.set(text: viewModel.user)
        rootView.passwordView.set(text: viewModel.password)
    }
    
    public func displayError(viewModel: Login.ErrorViewModel) {
        showAlert(withMessage: viewModel.error!)
    }
    
    private func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
