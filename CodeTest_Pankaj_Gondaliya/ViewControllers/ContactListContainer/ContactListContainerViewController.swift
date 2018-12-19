//
//  ContactListContainerViewController.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-18.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import UIKit

protocol ContactListContainerProtocol {
    func refreshSearchOnContactUpdate()
}

class ContactListContainerViewController: UIViewController {
    //Outlets
    @IBOutlet weak var collContact: UICollectionView!
    @IBOutlet weak var lblNoContact: UILabel!
    //Variables
    var presenter = ContactListPresenterImplementation()
    var delegate: ContactListContainerProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.presenterDelegate = self
        collContact.reloadData()
        initiateView()
        showNoContactAvailable()
    }
        
    //MARK: Initiate View
    func initiateView() {
        self.title = presenter.title
    }
    
    //MARK: Other Methods
    //Manage view on no contacts
    func showNoContactAvailable() {
        UIView.animate(withDuration: 0.5) {
            self.lblNoContact.alpha = self.presenter.manageNoContactsView()
        }
    }

}

// MARK: Collectionview Delegates
extension ContactListContainerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter.bisSearch == true {
            return presenter.arrSearchContact!.count
        } else {
            return ContactArray.arrContacts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let availableWidthForCell = collectionView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * CGFloat(presenter.kCellsPerRow )
        
        let cellWidth = availableWidthForCell / presenter.kCellsPerRow
        flowLayout.itemSize = CGSize.init(width: cellWidth, height: cellWidth)
        return CGSize(width:cellWidth, height: presenter.kHeightForRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactListCell", for: indexPath) as! ContactListCell
        cell.contactListPresenter.createShadow(frame: cell.frame)
        if (presenter.bisSearch == true) {
            cell.contactListPresenter.configureCell(contact: presenter.arrSearchContact![indexPath.row], row: indexPath.row)
        } else {
            cell.contactListPresenter.configureCell(contact: ContactArray.arrContacts[indexPath.row], row: indexPath.row)
        }
        cell.btnDelete.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(presenter.navigateToAddViewController(index: indexPath.row), animated: true)
    }
}

//MARK: ContactPresenterProtocol Methods
extension ContactListContainerViewController: ContactPresenterProtocol {
    func reloadTableOnContactUpdate() {
        collContact.reloadData()
        showNoContactAvailable()
        if(delegate != nil) {
            delegate?.refreshSearchOnContactUpdate()
        }
    }
}

//MARK: ContactListCellProtocol Methods
extension ContactListContainerViewController: ContactListCellProtocol {
    func deleteContactAtIndex(index: Int) {
        //Manage Database
        presenter.deleteContact(index: index)
        //Save data
        let archiver = Archiever()
        archiver.saveData(arrContact: ContactArray.arrContacts )

        //Update Home screen list
        delegate?.refreshSearchOnContactUpdate()

        let indexPath = IndexPath(item: index, section: 0)
        collContact.performBatchUpdates({
            collContact.deleteItems(at:[indexPath])
        }) { (success) in
            self.collContact.reloadData()
        }
        //Manage no contact view
        showNoContactAvailable()
    }
}
