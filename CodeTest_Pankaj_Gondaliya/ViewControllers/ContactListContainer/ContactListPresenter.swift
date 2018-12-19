//
//  ContactListPresenter.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import Foundation
import UIKit

protocol ContactPresenterProtocol {
    func reloadTableOnContactUpdate()
}

class ContactListPresenterImplementation {
    let title = "CONTACT"
    let kCellsPerRow: CGFloat = 1
    let kHeightForRow: CGFloat = 82
    var arrSearchContact: [Contact]?
    var bisSearch: Bool?
    
    var presenterDelegate: ContactPresenterProtocol? = nil
    
    //Manage no contact view
    func manageNoContactsView() -> CGFloat{
        if(bisSearch == true) {
            if(arrSearchContact!.count < 1) {
                return 1
            } else {
                return 0
            }
        } else {
            if(ContactArray.arrContacts.count < 1) {
                return 1
            } else {
                return 0
            }
        }
    }
    
    //Remove empty fields from Contact
    func removeEmptyFields() {
        for  contact in ContactArray.arrContacts {
            for email in contact.arrEmailAddress! {
                if( email.strEmailAddress == nil || email.strEmailAddress == "") {
                    if let index = contact.arrEmailAddress?.index(of:email) {
                        contact.arrEmailAddress?.remove(at: index)
                    }
                }
            }
            for phone in contact.arrPhoneNumber! {
                if(phone.strNumber == nil || phone.strNumber == "") {
                    if let index = contact.arrPhoneNumber?.index(of:phone) {
                        contact.arrPhoneNumber?.remove(at: index)
                    }
                }
            }
            for address in contact.arrAddress! {
                if(address.strAddress == nil || address.strAddress == "") {
                    if let index = contact.arrAddress?.index(of:address) {
                        contact.arrAddress?.remove(at: index)
                    }
                }
            }
        }
    }
    
    //Delete contact
    func deleteContact(index: Int) {
        if bisSearch == true {
            let contact = arrSearchContact![index]
            if let globalContact = ContactArray.arrContacts.first(where: {$0.strFirstName == contact.strFirstName}) {
                // do something with foo
                let indexOfContact = ContactArray.arrContacts.firstIndex(of: globalContact) // 0
                ContactArray.arrContacts.remove(at: indexOfContact!)
            }
            arrSearchContact!.remove(at: index)
        } else {
            ContactArray.arrContacts.remove(at: index)
        }
        
    }
    
    //Navigate to Add contact controller
    func navigateToAddViewController(index: Int? = nil)-> AddContactViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addViewController = storyBoard.instantiateViewController(withIdentifier: "AddContactViewController") as! AddContactViewController
        addViewController.presenterContactList = self
        addViewController.delegateAddContact = self
        //Edit
        if(index != nil) {
            addViewController.presenter = AddContactPresenterImplementation()
            if bisSearch == true {
                addViewController.presenter!.contact = arrSearchContact![index!]
            } else {
                addViewController.presenter!.contact = ContactArray.arrContacts[index!]
            }
            addViewController.bisEditContact = true
            addViewController.nIndex = index
        }
        return addViewController
    }
}

//MARK: AddContactViewControllerProtocol Methods
extension ContactListPresenterImplementation: AddContactViewControllerProtocol {
    func reloadTableOnListUpdate() {
        presenterDelegate?.reloadTableOnContactUpdate()
    }
}
