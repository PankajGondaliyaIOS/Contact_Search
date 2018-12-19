//
//  SearchViewController.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-18.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import UIKit

protocol SearchViewControllerProtocol {
    func refreshContacts()
}

class SearchViewController: UIViewController {
    //Outlets
    @IBOutlet weak  var searchBar: UISearchBar!
    @IBOutlet weak  var contactContainer: UIView!
    //Variables
    var delegate: SearchViewControllerProtocol?
    var controller: ContactListContainerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Initiate View
    func initiateView() {
        searchBar.searchBarStyle = .minimal;
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        textFieldInsideSearchBar?.font = UIFont.init(name: "HelveticaNeue-Medium", size: 14)
        addContactList()
    }
    
    //Create Contact list object
    func addContactList() {
        controller = storyboard!.instantiateViewController(withIdentifier: "ContactListContainerViewController") as? ContactListContainerViewController
        controller!.delegate = self
        controller.presenter.bisSearch = true
        controller.presenter.arrSearchContact = [Contact]()
        controller.presenter.arrSearchContact = ContactArray.arrContacts
        controller.view.frame = contactContainer.bounds
        addChild(controller)
        contactContainer.addSubview(controller.view)
    }
    
    //MARK: Action Methods
    @IBAction func back() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: BaseViewControllerProtocol Methods
extension SearchViewController: ContactListContainerProtocol {
    //Refresh Home Contact list
    func refreshSearchOnContactUpdate() {
        delegate?.refreshContacts()
    }
    
}

//MARK: UISearchBarDelegate Methods
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text! == "" {
            controller.presenter.arrSearchContact = ContactArray.arrContacts
        } else {
            // Filter the results
            controller.presenter.arrSearchContact = ContactArray.arrContacts.filter { $0.strFirstName.lowercased().contains(searchBar.text!.lowercased()) }
        }
        controller.collContact.reloadData()
        controller.showNoContactAvailable()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
