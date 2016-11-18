//
//  CharityList.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class CharityList {
    static var main = CharityList()
    var allCharities: [Charity]! = [Charity]()
    var launchedCharites: [Charity]! = [Charity]()
    
    // Test Initializer
    init(){
        for i in 0..<10 {
            let company = "Telus \(i)"
            let title = "Water 4 Elephants"
            let caption = "Donate your steps to save the elephants in Africa"
            let goalSteps = 100000 + i
            let expiredDate = NSDate(timeInterval: 30 * 86400, since: NSDate() as Date)
            let image = UIImage.init(named: "default-image-post")
            
            let charity = Charity(heldBy: company, title: title, caption: caption, goalSteps: goalSteps, expiredDate: expiredDate, image: image!)
            if charity.isExpired! == false{
                allCharities.append(charity)
            }
        }
        update()
    }
    
    func add(charity: Charity) {
        self.allCharities.insert(charity, at: 0)
    }
    
    func update() {
        launchedCharites = [Charity]()
        for charity in allCharities where charity.status == CharityStatus.lauching{
            launchedCharites.insert(charity, at: 0)
        }
    }
}
