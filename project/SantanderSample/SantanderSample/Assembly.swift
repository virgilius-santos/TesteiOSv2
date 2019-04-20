//
//  Assembly.swift
//  SantanderSample
//
//  Created by Virgilius Santos on 27/10/18.
//  Copyright © 2018 Virgilius Santos. All rights reserved.
//

import UIKit
import Swinject

class Assembly {
    
    private var container: Container
    
    lazy var loginVC: LoginViewController?
        = container.resolve(LoginViewController.self)
    
    lazy var detailVC: DetailsViewViewController?
        = container.resolve(DetailsViewViewController.self)
    
    static let shared = Assembly()
    private init() {
        container = Container()
        
        container.register(ServiceManager.self) { _ in
            return ServiceManager()
            }.inObjectScope(.container)
        
        setupLoginVC()
        setupDetailVC()
    }
    
    func setupLoginVC() {
    }
    
    func setupDetailVC() {
//        container.register(DetailWorker.self) { r in
//
//            worker.serviceManager = r.resolve(ServiceManager.self)
//            return worker
//        }
//        container.register(DetailInteractor.self) { r in
//
//            interactor.worker = r.resolve(DetailWorker.self)
//            return interactor
//        }
//        container.register(DetailPresenter.self) { _ in
//            return 
//        }
//        container.register(DetailRouter.self) { r in
//
//            router.dataStore = r.resolve(DetailInteractor.self)
//            return router
//        }
//        container.register(DetailsViewViewController.self) { r in
//            let nibName = String(describing: DetailsViewViewController.self)
//
//
//            let interactor = r.resolve(DetailInteractor.self)
//            let presenter = r.resolve(DetailPresenter.self)
//            let router = r.resolve(DetailRouter.self)
//
//            controller.interactor = interactor
//            router?.viewController = controller
//            interactor?.router = router
//            interactor?.presenter = presenter
//            presenter?.viewController = controller
//
//            return controller
//        }
    }
}
