//
//  UserProfile.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

enum Gender: String {
    case male, female, none
}

class UserProfile: NSObject, NSCoding {
    var totalSteps: Int!
    var currentSteps: Int!
    var gender: Gender!
    var heightInCm: Float!
    var weightInKg: Float!
    var dob: Date!
    
    override init(){
        super.init()
        self.totalSteps = 0
        self.currentSteps = 0
        self.gender = Gender.none
        heightInCm = 0
        weightInKg = 0
       
        // Default DOB
        let c = NSDateComponents()
        c.year = 1990
        c.month = 8
        c.day = 31
        
        // Get NSDate given the above date components
        dob = NSCalendar(identifier: NSCalendar.Identifier.gregorian)?.date(from: c as DateComponents)

    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        self.totalSteps = aDecoder.decodeObject(forKey: "totalSteps") as! Int!
        self.currentSteps = aDecoder.decodeObject(forKey: "currentSteps") as! Int!
        self.gender = Gender(rawValue: aDecoder.decodeObject(forKey: "gender") as! String!)
        self.heightInCm = aDecoder.decodeObject(forKey: "heightInCm") as! Float!
        self.weightInKg = aDecoder.decodeObject(forKey: "weightInKg") as! Float!
        self.dob = aDecoder.decodeObject(forKey: "dob") as! Date!
    }
    

    // Donate number of steps to a charity 
    func donate(steps: Int, for charity: Charity){
        if charity.status == CharityStatus.lauching {
            charity.currentSteps = charity.currentSteps + steps
        }
        self.currentSteps = self.currentSteps - steps
        //charity.status = CharityStatus.registered
        //self.currentCharity? = charity
        //let index = CharityList.main.launchedCharites.index(of: charity)
        //CharityList.main.launchedCharites.remove(at: index!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(totalSteps, forKey: "totalSteps")
        aCoder.encode(currentSteps, forKey: "currentSteps")
        aCoder.encode(gender.rawValue, forKey: "gender")
        aCoder.encode(heightInCm, forKey: "heightInCm")
        aCoder.encode(weightInKg, forKey: "weightInKg")
        aCoder.encode(dob, forKey: "dob")
    }
    
}
