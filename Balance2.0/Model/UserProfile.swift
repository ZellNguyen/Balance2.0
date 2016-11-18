//
//  UserProfile.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class UserProfile: NSObject, NSCoding {
    var totalSteps: Int!
    var currentSteps: Int!
    //var currentCharity: Charity?
    
    override init(){
        super.init()
        self.totalSteps = 0
        self.currentSteps = 0
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        self.totalSteps = aDecoder.decodeObject(forKey: "totalSteps") as! Int!
        self.currentSteps = aDecoder.decodeObject(forKey: "currentSteps") as! Int!
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
    }
    
}
