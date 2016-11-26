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
    
    var dailySteps: Int! = 0
    var weeklySteps: Int! = 0
    var monthlySteps: Int! = 0
    
    var picture: UIImage!
    
    override init(){
        super.init()
        self.totalSteps = 25000
        self.currentSteps = 25000
        self.dailySteps = 25000
        self.weeklySteps = 100456
        self.monthlySteps = 300234
        
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
        
        // Default profile pic
        self.picture = UIImage.init(named: "Alice 1")

    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        self.totalSteps = aDecoder.decodeObject(forKey: "totalSteps") as! Int!
        self.currentSteps = aDecoder.decodeObject(forKey: "currentSteps") as! Int!
        self.gender = Gender(rawValue: aDecoder.decodeObject(forKey: "gender") as! String!)
        self.heightInCm = aDecoder.decodeObject(forKey: "heightInCm") as! Float!
        self.weightInKg = aDecoder.decodeObject(forKey: "weightInKg") as! Float!
        self.dob = aDecoder.decodeObject(forKey: "dob") as! Date!
        self.picture = aDecoder.decodeObject(forKey: "picture") as! UIImage!
        self.dailySteps = aDecoder.decodeObject(forKey: "dailySteps") as! Int!
        self.weeklySteps = aDecoder.decodeObject(forKey: "weeklySteps") as! Int!
        self.monthlySteps = aDecoder.decodeObject(forKey: "monthlySteps") as! Int!
    }
    

    // Donate number of steps to a charity 
    func donate(steps: Int, for charity: Charity){
        if charity.status == CharityStatus.lauching {
            charity.currentSteps = charity.currentSteps + steps
            let charityCopy = charity.copy() as! Charity
            charityCopy.donatedDate = Date()
            charityCopy.donatedSteps = currentSteps
            CharityList.donated.insert(charityCopy, at: 0)
        }
        self.currentSteps = self.currentSteps - steps
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(totalSteps, forKey: "totalSteps")
        aCoder.encode(currentSteps, forKey: "currentSteps")
        aCoder.encode(gender.rawValue, forKey: "gender")
        aCoder.encode(heightInCm, forKey: "heightInCm")
        aCoder.encode(weightInKg, forKey: "weightInKg")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(picture, forKey: "picture")
        aCoder.encode(dailySteps, forKey: "dailySteps")
        aCoder.encode(weeklySteps, forKey: "weeklySteps")
        aCoder.encode(monthlySteps, forKey: "monthlySteps")
    }
}
