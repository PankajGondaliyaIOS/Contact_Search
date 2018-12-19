//
//  Archiver.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-18.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import Foundation
class Archiever { //Avoiding singleton as there is no need for this call to be always in memory
    
    var filePath: String {
        //1 - manager lets you examine contents of a files and folders in your app; creates a directory to where we are saving it
        let manager = FileManager.default
        //2 - this returns an array of urls from our documentDirectory and we take the first path
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        //3 - creates a new path component and creates a new file called "Data" which is where we will store our Data array.
        return (url!.appendingPathComponent("Data").path)
    }
    
    

    func saveData(arrContact: [Contact]) {
            NSKeyedArchiver.archiveRootObject(arrContact, toFile: filePath)
        
        }
        
        func loadData()-> [Contact] {
            do {
                if let arrContacts = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Contact] {
                    return arrContacts
                }
                return [Contact]()
            }
        }
}
