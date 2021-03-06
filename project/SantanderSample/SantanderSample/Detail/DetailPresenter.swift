//
//  DetailPresenter.swift
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

protocol DetailPresentationLogic
{
    func present(response: Detail.Response)
    func presentUserInfo(response: Detail.Response)
}

class DetailPresenter: NSObject
{
    weak var viewController: DetailDisplayLogic?
}

extension DetailPresenter: DetailPresentationLogic
{
    func presentUserInfo(response: Detail.Response)
    {
        var viewModel = Detail.ViewModel()
        viewModel.name = response.name
        
        if let ac = response.agency, let ag = response.bankAccount {
           
            let mStr = NSMutableString(string: ac)
            mStr.insert("-", at: ac.count-1)
            mStr.insert(".", at: 2)
            viewModel.account = "\(ag) / \(mStr)"
        }
        
        viewModel.balance = response.balance?.currency
        
        
        DispatchQueue.main.async {
            self.viewController?.displayUserInfo(viewModel: viewModel)
        }
        
    }
    
    func present(response: Detail.Response)
    {
        
        let detailList = response
            .statementList
            .map {
                (st) -> Detail.StatementViewModel in
                var stVM = Detail.StatementViewModel()
                stVM.desc = st.desc
                stVM.title = st.title
                stVM.value = st.value.currency
                
                let date = st.date.toDate(format: .apiDate)
                stVM.date = date.toString(format: .displayDate)
                
                return stVM
        }
        
        DispatchQueue.main.async {
            self.viewController?.displayDetail(detailList)
        }
    }
}
