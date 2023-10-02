import UIKit

protocol LoginDisplayLogic: AnyObject {
    func startLoading()
    func stopLoading()
    func displayError(viewModel: Login.ErrorViewModel)
    func displayLastUser(viewModel: Login.LastUserViewModel)
}

final class LoginViewController: UIViewController {
    let interactor: LoginBusinessLogic
    lazy var rootView = LoginView()
    
    init(interactor: LoginBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureIdView()
        configurePasswordView()
        configureLoginAction()
        
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            rootView.passwordView.textField.becomeFirstResponder()
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
        rootView.idView.set(text: viewModel.user)
        rootView.passwordView.set(text: viewModel.password)
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
        present(alertController, animated: true, completion: nil)
    }
}
