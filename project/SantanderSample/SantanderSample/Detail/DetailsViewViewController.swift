//
//  DetailsViewViewController.swift
//  SantanderSample
//
//  Created by Virgilius Santos on 27/10/18.
//  Copyright © 2018 Virgilius Santos. All rights reserved.
//

import UIKit

protocol DetailDisplayLogic: class
{
    func displaySomething(viewModel: Detail.ViewModel)
}

class DetailsViewViewController: UIViewController {

    let cellIdentifier = String(describing: DetailCell.self)
    
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("-----  load ----")
    }
    
    // MARK: Do something
    
    @IBOutlet weak var exitView: ExitButtonView! {
        didSet {
            let button = exitView.exitButton
            button?.addTarget(self,
                              action: #selector(exitAction),
                              for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var nameView: InfoDetailView!
    
    @IBOutlet weak var accountTitleView: TitleDetailView! {
        didSet {
            accountTitleView.titleLabel.text = "Conta"
        }
    }
    @IBOutlet weak var accountInfoView: InfoDetailView!
    
    @IBOutlet weak var balanceTitleView: TitleDetailView! {
        didSet {
            balanceTitleView.titleLabel.text = "Saldo"
        }
    }
    @IBOutlet weak var balnceInfoView: InfoDetailView!
    
    @IBOutlet weak var entriesCollectionView: UICollectionView! {
        didSet {
            entriesCollectionView.delegate = self
            entriesCollectionView.dataSource = self
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            entriesCollectionView
                .register(nib, forCellWithReuseIdentifier: cellIdentifier)
        }
    }
    
    @objc func exitAction() {
        
    }

}

extension DetailsViewViewController: DetailDisplayLogic{
    func displaySomething(viewModel: Detail.ViewModel) {
        
    }
}


extension DetailsViewViewController: UICollectionViewDelegate {
    
}

extension DetailsViewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DetailCell
        
        return cell
    }
    
    
}