//
//  LoginConfigurator.swift
//  SantanderSample
//
//  Created by Virgilius Santos on 20/04/19.
//  Copyright © 2019 Virgilius Santos. All rights reserved.
//

import UIKit

final class LoginConfigurator
{
    
    let service: ServiceManager
    
    init(service: ServiceManager)
    {
        self.service = service
    }
    
    func build() -> UIViewController
    {
        let worker = LoginWorker(service: service)
        let router = LoginRouter()
        let presenter = LoginPresenter()
        
        let interactor = LoginInteractor(
            worker: worker,
            router: router,
            presenter: presenter)
        
        let controller = LoginViewController(interactor: interactor)
        
        router.dataStore = interactor
        router.viewController = controller
        router.worker = worker
        
        presenter.viewController = controller
        
        return controller
    }
}
