//
//  DetailRouter.swift
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

@objc protocol DetailRoutingLogic
{
    func routeToLogin()
}

class DetailRouter: NSObject
{
    weak var viewController: DetailsViewViewController?
    
    // MARK: Navigation
    
    func dismiss()
    {
        DispatchQueue.main.async {
            self.viewController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension DetailRouter: DetailRoutingLogic
{
    func routeToLogin()
    {
        dismiss()
    }
}
