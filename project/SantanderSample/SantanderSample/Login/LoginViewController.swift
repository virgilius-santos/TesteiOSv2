//
//  LoginViewController.swift
//  SantanderSample
//
//  Created by Virgilius Santos on 26/10/18.
//  Copyright (c) 2018 Virgilius Santos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginDisplayLogic: class
{
  func displaySomething(viewModel: Login.Something.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic
{
    
    @IBOutlet weak var logoView: LogoView!
    @IBOutlet weak var idView: InputTextView! {
        didSet {
            idView.setPlaceholder("User")
            idView.textField.delegate = self
        }
    }
    @IBOutlet weak var passwordView: InputTextView! {
        didSet {
            passwordView.setPlaceholder("Password")
            passwordView.textField.delegate = self
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
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup()
    {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
                if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        KeyboardManager.shared.enable = true
        doSomething()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        KeyboardManager.shared.enable = false
    }
    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doSomething()
    {
        let request = Login.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: Login.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    @objc func loginAction() {
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
