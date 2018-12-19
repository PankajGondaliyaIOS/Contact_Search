//
//  AddContactCell.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import UIKit

class AddContactCell: UITableViewCell {
    @IBOutlet var txtDetail: UITextField!
    let arrPlaceHolder = ["First name", "Last name", "Date of birth", "Address", "Phone number", "Email address"]
    let addContactCellPresenter = AddContactCellPresenter()

    override func awakeFromNib() {
        super.awakeFromNib()
        addContactCellPresenter.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension AddContactCell: AddContactCellPresenterPresenterProtocol {
    //Fill contacts
    func fillContactDetail(contact: Contact, indexPath: IndexPath) {
        //Add data to cell
            switch indexPath.section {
            case 0:
                txtDetail.text = contact.strFirstName
            case 1:
                txtDetail.text = contact.strLastName
            case 2:
                txtDetail.text = contact.strDateOfBirth
            case 3:
                let address = contact.arrAddress?[indexPath.row]
                txtDetail.text = address?.strAddress
            case 4:
                let phone = contact.arrPhoneNumber?[indexPath.row]
                txtDetail.text = phone?.strNumber
            case 5:
                let email = contact.arrEmailAddress?[indexPath.row]
                txtDetail.text = email?.strEmailAddress
            default:
                print("Default")
            }
    }
    
    //Create placeholder
    func createPlaceHolder(index: Int) {
            txtDetail.placeholder = arrPlaceHolder[index]
            switch index {
            case 4:
                txtDetail.keyboardType = .numberPad
            case 5:
                txtDetail.keyboardType = .emailAddress
            default:
                print("Default")
        }
    }    
}
