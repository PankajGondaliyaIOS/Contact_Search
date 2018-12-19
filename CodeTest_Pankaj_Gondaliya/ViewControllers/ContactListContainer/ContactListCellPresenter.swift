//
//  ContactListCellPresenter.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import Foundation
import UIKit

protocol ContactListCellPresenterProtocol {
    func setTitle(strTitle: String)
    func setDateOfBirth(strTitle: String)
    func configureButton(nButtonTag: Int)
    func configureUI(layer: CALayer)
}

class ContactListCellPresenterImplementation {
    
    var delegate: ContactListCellPresenterProtocol? = nil    // <-- delegate
    
    func createShadow(frame: CGRect) {
        let layer = CALayer()
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        layer.cornerRadius = 5.0
        layer.shadowPath = UIBezierPath(roundedRect:frame, cornerRadius: 5).cgPath
        delegate?.configureUI(layer: layer)
    }
    
    func configureCell(contact: Contact, row: Int) {
        if(delegate != nil) {
            delegate?.setTitle(strTitle: ("\(contact.strFirstName) \(contact.strLastName)"))
            delegate?.setDateOfBirth(strTitle: contact.strDateOfBirth)
            delegate?.configureButton(nButtonTag: row)
        }
    }
    
}
