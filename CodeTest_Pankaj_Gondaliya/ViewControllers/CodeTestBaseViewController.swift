//
//  CodeTestBaseViewController.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import UIKit

@objc protocol BaseViewControllerProtocol {
    @objc optional func searchNavigateClicked()
    @objc optional func addNavigateClicked()
    @objc optional func doneNavigateClicked()
}

class CodeTestBaseViewController: UIViewController {
    
    var delegate: BaseViewControllerProtocol? = nil    // <-- delegate

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Left Navigation Button
    func setAddButton() {
        let addButton = UIBarButtonItem(title: "ADD", style: .plain, target: self, action: #selector(self.leftNavigationAdd))
        self.navigationItem.leftBarButtonItems = [addButton]
    }
    
    @objc func leftNavigationAdd() {
        delegate?.addNavigateClicked!()
    }

    //MARK: Right Navigation Button
    //Search
    func setSearchButton() {
        let search = UIImage(named: "search")!
        let searchButton = UIBarButtonItem(image: search,  style: .plain, target: self, action: #selector(self.rightNavigationSearch))
        self.navigationItem.rightBarButtonItems = [searchButton]
    }
    
    @objc func rightNavigationSearch() {
        delegate?.searchNavigateClicked!()
    }

    //Done/Save/Edit
    func setDoneButton() {
        let doneButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(self.rightNavigationDone))
        self.navigationItem.rightBarButtonItems = [doneButton]
    }
    
    @objc func rightNavigationDone() {
        delegate?.doneNavigateClicked!()
    }

}
