//
//  AddContactCellPresenter.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-18.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

protocol AddContactCellPresenterPresenterProtocol {
    func fillContactDetail(contact: Contact, indexPath: IndexPath )
    func createPlaceHolder(index: Int) 
}

import Foundation

class AddContactCellPresenter {
    var delegate: AddContactCellPresenterPresenterProtocol? = nil

    //Fill Contact
    func fillContactDetails(contact: Contact, indexPath: IndexPath ) {
        delegate?.fillContactDetail(contact: contact, indexPath: indexPath)
    }
    
    //Create Placeholder
    func createPlaceHolderForTextFields(index: Int) {
        delegate?.createPlaceHolder(index: index )
    }

}
