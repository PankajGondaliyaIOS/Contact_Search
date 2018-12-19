//
//  ViewSectionHeader.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import UIKit

protocol ViewSectionHeaderProtocol {
    func didselctHeaderAtIndexPath(section: Int)
}


class ViewSectionHeader: UITableViewHeaderFooterView {
    var delegate: ViewSectionHeaderProtocol? = nil    // <-- delegate

    @IBOutlet weak var btnAddPhoneNumber: UIButton!
    
    //To expand a perticular section
    @IBAction func btnAddPhoneNumberClicked(button: UIButton) {
        delegate?.didselctHeaderAtIndexPath(section: button.tag)
    }
    
}
