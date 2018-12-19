//
//  ContactListCell.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import UIKit

protocol ContactListCellProtocol {
    func deleteContactAtIndex(index: Int)
}

class ContactListCell: UICollectionViewCell {
    
    let contactListPresenter = ContactListCellPresenterImplementation()
    var delegate: ContactListCellProtocol? = nil
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateOfBirth: UILabel!
    @IBOutlet weak var btnDelete: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        contactListPresenter.delegate = self
    }
    
    //Delete contact
    @IBAction func btnDeleteClicked(button: UIButton) {
        delegate?.deleteContactAtIndex(index: button.tag)
    }
    
}

//MARK: ContactListCellPresenterProtocol Methods
extension ContactListCell: ContactListCellPresenterProtocol {
    
    func configureUI(layer: CALayer) {
        self.layer.shadowPath = layer.shadowPath
    }
    
    func setDateOfBirth(strTitle: String) {
        lblDateOfBirth.text = strTitle
    }
    
    func configureButton(nButtonTag: Int) {
        btnDelete.tag = nButtonTag
    }
    
    func setTitle(strTitle: String) {
        lblName.text = strTitle
    }
}
