//
//  DetailInteractor.swift
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

protocol DetailBusinessLogic
{
  func doSomething(request: Detail.Something.Request)
}

protocol DetailDataStore
{
  //var name: String { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore
{
  var presenter: DetailPresentationLogic?
  var worker: DetailWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Detail.Something.Request)
  {
    worker = DetailWorker()
    worker?.doSomeWork()
    
    let response = Detail.Something.Response()
    presenter?.presentSomething(response: response)
  }
}