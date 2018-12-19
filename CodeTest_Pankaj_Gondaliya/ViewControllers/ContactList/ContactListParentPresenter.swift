//
//  ContactListParentPresenter.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-18.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import Foundation
import UIKit

class ContactListParentPresenter {
    let title = "CONTACT"
    var contactListContainerViewController: ContactListContainerViewController?
    
    func addContactList() -> ContactListContainerViewController{
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        contactListContainerViewController = storyBoard.instantiateViewController(withIdentifier: "ContactListContainerViewController") as? ContactListContainerViewController
        return contactListContainerViewController!
    }

    //Navigate to Add Contact
    func navigateToAddViewController(index: Int? = nil)-> AddContactViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addViewController = storyBoard.instantiateViewController(withIdentifier: "AddContactViewController") as! AddContactViewController
        addViewController.presenterContactList = contactListContainerViewController?.presenter
        addViewController.delegateAddContact = contactListContainerViewController?.presenter
        //Edit
        if(index != nil) {
            addViewController.presenter = AddContactPresenterImplementation()
            addViewController.presenter!.contact = ContactArray.arrContacts[index!]//contactListContainerViewController?.presenter.arrContacts[index!]
            addViewController.bisEditContact = true
            addViewController.nIndex = index
        }
        
        return addViewController
    }
    
    //Navigate to Search
    func navigateToSearchViewController()-> SearchViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let searchiewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchiewController.delegate = self
        return searchiewController
    }
}

//MARK: SearchViewControllerProtocol Methods
extension ContactListParentPresenter: SearchViewControllerProtocol {
    //Refresh contact on add, update, delete
    func refreshContacts() {
        contactListContainerViewController?.collContact.reloadData()
        contactListContainerViewController?.showNoContactAvailable()
    }
}
