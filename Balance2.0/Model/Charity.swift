//
//  Charity.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

enum CharityStatus: String {
    case lauching = "Lauching"
    case finished = "finished"
}

class Charity: NSObject, NSCoding {
    var company: String!
    var title: String!
    var caption: String!
    var goalSteps: Int!
    var currentSteps: Int! {
        didSet {
            if currentSteps >= goalSteps {
                self.status = .finished
            }
        }
    }
    var expiredDate: NSDate!
    var status: CharityStatus!
    
    var image: UIImage!
    
    var isExpired: Bool! {
            return expiredDate.compare(NSDate() as Date) == .orderedAscending ? true : false
    }
    
    init(heldBy company: String, title: String, caption: String, goalSteps: Int, currentSteps: Int, expiredDate: NSDate, image: UIImage, status: CharityStatus){
        super.init()
        
        self.company = company
        self.title = title
        self.caption = caption
        self.goalSteps = goalSteps
        self.expiredDate = expiredDate
        self.image = image
        
        self.currentSteps = currentSteps
        self.status = CharityStatus.lauching

    }
    
    convenience init(heldBy company: String, title: String, caption: String, goalSteps: Int, expiredDate: NSDate, image: UIImage){
        self.init(heldBy: company, title: title, caption: caption, goalSteps: goalSteps, currentSteps: 0, expiredDate: expiredDate, image: image, status: CharityStatus.lauching)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let company = aDecoder.decodeObject(forKey: "company") as! String!
        let title = aDecoder.decodeObject(forKey: "title") as! String!
        let caption = aDecoder.decodeObject(forKey: "caption") as! String!
        let goalSteps = aDecoder.decodeObject(forKey: "goalSteps") as! Int!
        let currentSteps = aDecoder.decodeObject(forKey: "currentSteps") as! Int!
        let expiredDate = aDecoder.decodeObject(forKey: "expiredDate") as! NSDate!
        let status = CharityStatus(rawValue: aDecoder.decodeObject(forKey: "status") as! String!)
        let image = aDecoder.decodeObject(forKey: "image") as! UIImage!
        
        self.init(heldBy: company!, title: title!, caption: caption!, goalSteps: goalSteps!, currentSteps: currentSteps!, expiredDate: expiredDate!, image: image!, status: status!)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.company, forKey: "company")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.caption, forKey: "caption")
        aCoder.encode(self.goalSteps, forKey: "goalSteps")
        aCoder.encode(self.currentSteps, forKey: "currentSteps")
        aCoder.encode(self.expiredDate, forKey: "expiredDate")
        aCoder.encode(self.status.rawValue, forKey: "status")
        aCoder.encode(self.image, forKey: "image")
    }
}
