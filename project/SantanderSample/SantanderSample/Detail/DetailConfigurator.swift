//
//  DetailConfigurator.swift
//  SantanderSample
//
//  Created by Virgilius Santos on 20/04/19.
//  Copyright © 2019 Virgilius Santos. All rights reserved.
//

import UIKit

final class DetailConfigurator
{
    
    let service: ServiceManager
    let user: Login.UserAccount
    
    init(service: ServiceManager, user: Login.UserAccount)
    {
        self.service = service
        self.user = user
    }
    
    func build() -> UIViewController
    {
        let worker = DetailWorker(service: service)
        let router = DetailRouter()
        let presenter = DetailPresenter()
        
        let interactor = DetailInteractor(
            worker: worker,
            router: router,
            presenter: presenter,
            user: user)
        
        let controller = DetailsViewViewController(interactor: interactor)
        controller.detailDataSource = presenter
        
        router.viewController = controller
        presenter.viewController = controller
        
        return controller
    }
}
