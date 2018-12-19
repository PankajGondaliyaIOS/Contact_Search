//
//  AddContactViewController.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import UIKit

protocol AddContactViewControllerProtocol {
    func reloadTableOnListUpdate()
}

class AddContactViewController: CodeTestBaseViewController {
    var presenter: AddContactPresenterImplementation?
    var presenterContactList: ContactListPresenterImplementation?
    
    @IBOutlet weak var tblContact: UITableView!
    var delegateAddContact: AddContactViewControllerProtocol? = nil
    
    //Edit Contact
    var bisEditContact: Bool?
    var nIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateView()
    }
    
    //MARK: Initiate View
    func initiateView() {
        super.setDoneButton()
        super.delegate = self
        tblContact.register(UINib(nibName: "ViewSectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "ViewSectionHeader")
        //Add
        if(presenter == nil) {
            presenter = AddContactPresenterImplementation()
            presenter?.initiateContact()
            self.title = presenter?.titleAdd
        } else { //edit
            self.title = presenter?.titleEdit
        }
        tblContact.delegate = self
        tblContact.dataSource = self
        tblContact.tableFooterView = UIView()
        tblContact.reloadData()
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: Action Method
    @IBAction func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: Tableview Methods
extension AddContactViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 3) {
            return (presenter?.contact.arrAddress?.count ?? -1 - 1)
        } else if(section == 4) {
            return (presenter?.contact.arrPhoneNumber?.count ?? -1 - 1)
        } else if(section == 5) {
            return presenter?.contact.arrEmailAddress?.count ?? -1 - 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section < 3) {
            return 0
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddContactCell") as! AddContactCell
        if bisEditContact == true {
            cell.addContactCellPresenter.fillContactDetails(contact: presenter!.contact, indexPath: indexPath)
        }
        cell.addContactCellPresenter.createPlaceHolderForTextFields(index: indexPath.section)
        cell.selectionStyle = .none
        cell.txtDetail.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section < 3) {
            return UIView()
        } else {
            let headerview = presenter?.headerViewForSection(section: section, tableview: tableView)
            headerview?.delegate = self
            return headerview
        }
    }
    
}

//MARK: ViewSectionHeaderProtocol Methods
extension AddContactViewController: BaseViewControllerProtocol {
    func doneNavigateClicked() {
        view.endEditing(true)
        if presenter?.validateContactDetails() == true {
        presenter?.saveOrEditContact(bisEditContact: bisEditContact ?? false, presenterContactList: presenterContactList!, nIndex: nIndex ?? nil)
            delegateAddContact?.reloadTableOnListUpdate()
            navigationController?.popViewController(animated: true)
        } else {
            showToastWithMessage(message: "First name, last name, and date of birth is required to store contact")
        }
    }
}

//MARK: ViewSectionHeaderProtocol Methods
extension AddContactViewController: ViewSectionHeaderProtocol {
    func didselctHeaderAtIndexPath(section: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // create proper animation
            self.tblContact.beginUpdates()
            var indexPath:IndexPath = IndexPath()
            if(section == 3) {
                self.presenter!.contact.arrAddress?.append(Address())
                indexPath = IndexPath(row: self.presenter!.contact.arrAddress!.count-1, section: section)
            } else if(section == 4) {
                self.presenter!.contact.arrPhoneNumber?.append(PhoneNumber())
                indexPath = IndexPath(row:self.presenter!.contact.arrPhoneNumber!.count-1 , section:section)
            } else if(section == 5) {
                self.presenter!.contact.arrEmailAddress?.append(EmailAddress())
                indexPath = IndexPath(row:self.presenter!.contact.arrEmailAddress!.count-1, section:section)
            }
            self.tblContact.insertRows(at: [indexPath], with: .left)
            self.tblContact.endUpdates()
            self.tblContact.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

//MARK: UITextFieldDelegate Methods
extension AddContactViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter?.textfieldDidEndEditing(textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
