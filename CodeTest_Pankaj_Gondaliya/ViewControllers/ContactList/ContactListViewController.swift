//
//  ContactListViewController.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import UIKit


class ContactListViewController: CodeTestBaseViewController {
    //Outlets
    @IBOutlet weak  var contactContainer: UIView!
    //Variables
    var presenter = ContactListParentPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: Initiate View
    func initiateView() {
        //Get Saved Data from Database
        let archiver = Archiever()
        ContactArray.arrContacts = archiver.loadData()
        //Design set up
        self.title = presenter.title
        super.setSearchButton()
        super.setAddButton()
        super.delegate = self
        addContactList()
    }
    
    func addContactList() {
        let controller = presenter.addContactList()
        controller.view.frame = contactContainer.bounds
        addChild(controller)
        contactContainer.addSubview(controller.view)
    }
}

//MARK: BaseViewControllerProtocol Methods
extension ContactListViewController: BaseViewControllerProtocol {
    func addNavigateClicked() {
        self.navigationController?.pushViewController(presenter.navigateToAddViewController(), animated: true)
    }
    
    func searchNavigateClicked() {
        self.navigationController?.pushViewController(presenter.navigateToSearchViewController(), animated: true)
    }
}
