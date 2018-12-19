//
//  Utility.swift
//  Localisation
//
//  Created by Pankaj on 10/19/18.
//  Copyright © 2018 Pankaj Gondaliya. All rights reserved.
//

import Foundation
import UIKit
//Show alert toast
func showToastWithMessage(message: String) {
    UIApplication.shared.keyWindow?.makeToast(message: message, duration: 3.0, position: "bottom" as AnyObject)
}

struct ContactArray {
    static var arrContacts = [Contact]()
}
