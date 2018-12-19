//
//  Contact.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import Foundation

class Contact: NSObject, NSCoding {
//    var strFirstName = NSUUID().uuidString
    var strFirstName = ""
    var strLastName = ""
    var strDateOfBirth = ""
    var arrAddress: [Address]?
    var arrPhoneNumber: [PhoneNumber]?
    var arrEmailAddress: [EmailAddress]?
    
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(strFirstName, forKey: "strFirstName")
        aCoder.encode(strFirstName, forKey: "strFirstName")
        aCoder.encode(strLastName, forKey: "strLastName")
        aCoder.encode(strDateOfBirth, forKey: "strDateOfBirth")
        aCoder.encode(arrAddress, forKey: "arrAddress")
        aCoder.encode(arrPhoneNumber, forKey: "arrPhoneNumber")
        aCoder.encode(arrEmailAddress, forKey: "arrEmailAddress")
    }
    
    override init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
//        self.strFirstName = aDecoder.decodeObject(forKey: "strFirstName") as! String
        self.strFirstName = aDecoder.decodeObject(forKey: "strFirstName") as! String
        self.strLastName = aDecoder.decodeObject(forKey: "strLastName") as! String
        self.strDateOfBirth = aDecoder.decodeObject(forKey: "strDateOfBirth") as! String
        self.arrAddress = aDecoder.decodeObject(forKey: "arrAddress") as? [Address]
        self.arrPhoneNumber = aDecoder.decodeObject(forKey: "arrPhoneNumber") as? [PhoneNumber]
        self.arrEmailAddress = aDecoder.decodeObject(forKey: "arrEmailAddress") as? [EmailAddress]
    }
    
}

class Address: NSObject, NSCoding {
    var strAddress: String?
    
    override init() {
        
    }
    
    init(strAddress: String) {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(strAddress, forKey: "strAddress")
    }
    
    required init?(coder aDecoder: NSCoder) {
        strAddress = aDecoder.decodeObject(forKey: "strAddress") as? String
    }

}

class PhoneNumber: NSObject, NSCoding {
    var strNumber: String?
    override init() {
        
    }
    
    init(strNumber: String) {
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(strNumber, forKey: "strNumber")
    }
    
    required init?(coder aDecoder: NSCoder) {
        strNumber = aDecoder.decodeObject(forKey: "strNumber") as? String
    }

}

class EmailAddress: NSObject, NSCoding {
    var strEmailAddress: String?
    override init() {
        
    }
    
    init(strEmailAddress: String) {
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(strEmailAddress, forKey: "strEmailAddress")
    }
    
    required init?(coder aDecoder: NSCoder) {
        //add code here
        strEmailAddress = aDecoder.decodeObject(forKey: "strEmailAddress") as? String
    }

}
