//
//  LoginPresenter.swift
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

protocol LoginPresentationLogic
{
    func present(error: Login.ErrorType)
    func present(lastLogin: Login.LoginSave)
}

class LoginPresenter
{
    
    weak var viewController: LoginDisplayLogic?
}

extension LoginPresenter: LoginPresentationLogic {
    
    func present(error: Login.ErrorType) {
        
        var viewModel = Login.ErrorViewModel()
        viewModel.error = error.message
        
        DispatchQueue.main.async {
            self.viewController?.displayError(viewModel: viewModel)
        }
    }
    
    func present(lastLogin: Login.LoginSave) {
        
        var viewModel = Login.LastUserViewModel()
        viewModel.user = lastLogin.user
        viewModel.password = lastLogin.password
        
        DispatchQueue.main.async {
            self.viewController?.displayLastUser(viewModel: viewModel)
        }
    }
}
