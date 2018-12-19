//
//  AddContactPresenter.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import Foundation
import UIKit

class AddContactPresenterImplementation {
    var contact: Contact!
    let titleAdd = "NEW CONTACT"
    let titleEdit = "EDIT CONTACT"
    
    func initiateContact() {
        contact = Contact()
        contact.arrAddress = [Address]()
        contact.arrEmailAddress = [EmailAddress]()
        contact.arrPhoneNumber = [PhoneNumber]()
    }
    
    //Create header set up
    func headerViewForSection(section: Int, tableview: UITableView) -> ViewSectionHeader{
        let headerView = tableview.dequeueReusableHeaderFooterView(withIdentifier: "ViewSectionHeader") as! ViewSectionHeader
        headerView.btnAddPhoneNumber.tag = section
        switch section {
        case 3:
            headerView.btnAddPhoneNumber.setTitle("+ Address", for: .normal)
        case 4:
            headerView.btnAddPhoneNumber.setTitle("+ Phone Number", for: .normal)
        case 5:
            headerView.btnAddPhoneNumber.setTitle("+ Email Address", for: .normal)
        default:
            print("Default")
        }
        return headerView
    }
    
    //Basic validation. Have ignored major validation.
    func validateContactDetails()-> Bool {
        if(contact.strFirstName.trimmingCharacters(in: .whitespaces).isEmpty == true || contact.strLastName.trimmingCharacters(in: .whitespaces).isEmpty == true || contact.strDateOfBirth.trimmingCharacters(in: .whitespaces).isEmpty == true) {
            return false
        } else {
            return true
        }
    }
    
    //Save and Edit Contact
    func saveOrEditContact(bisEditContact: Bool, presenterContactList: ContactListPresenterImplementation, nIndex: Int?) {
        // Stor to DB
        if(presenterContactList.bisSearch == true) {
            //Edit
            if bisEditContact == true {
                //presenterContactList.arrContacts[nIndex!] = contact
                presenterContactList.arrSearchContact![nIndex!] = contact
                if let globalContact = ContactArray.arrContacts.first(where: {$0.strFirstName == contact.strFirstName}) {
                    // do something with foo
                    let indexOfContact = ContactArray.arrContacts.firstIndex(of: globalContact) // 0
                    ContactArray.arrContacts[indexOfContact!] = contact
                }
                showToastWithMessage(message: "The contact has been edited successfully")
            }
        } else {
            //Edit
            if bisEditContact == true {
                //presenterContactList.arrContacts[nIndex!] = contact
                ContactArray.arrContacts[nIndex!] = contact
                showToastWithMessage(message: "The contact has been edited successfully")
            } else { // Add
                //presenterContactList.arrContacts.append(contact)
                ContactArray.arrContacts.append(contact)
                showToastWithMessage(message: "The contact has been stored successfully")
            }
        }
        presenterContactList.removeEmptyFields()
        //Store Data
        let archiver = Archiever()
        archiver.saveData(arrContact: ContactArray.arrContacts )
    }
    
    //Fill Contact
    func textfieldDidEndEditing(textField: UITextField) {
        switch textField.placeholder {
        case "First name":
            contact.strFirstName = textField.text ?? ""
            break
        case "Last name":
            contact.strLastName = textField.text ?? ""
            break
        case "Date of birth":
            contact.strDateOfBirth = textField.text ?? ""
            break
        case "Address":
            let address = contact.arrAddress![textField.tag]
            address.strAddress = textField.text
            contact.arrAddress![textField.tag] = address
            break
        case "Phone number":
            let phone = contact.arrPhoneNumber![textField.tag]
            phone.strNumber = textField.text
            contact.arrPhoneNumber![textField.tag] = phone
            break
        case "Email address":
            let email = contact.arrEmailAddress![textField.tag]
            email.strEmailAddress = textField.text
            contact.arrEmailAddress![textField.tag] = email
            break
        default:
            print("Default")
        }
    }
}

