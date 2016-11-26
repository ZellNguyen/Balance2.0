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
    static var donated = [Charity]()
    var allCharities: [Charity]! = [Charity]()
    var launchedCharites: [Charity]! = [Charity]()
    
    // Test Initializer
    init(){
        let company1 = "USA"
        let title1 = "World Food Program"
        let caption1 = "1 out of every 9 people worldwide suffers from chronic hunger.\nWorld Food Program aims to gather $650,000 to help children in Syria."
        let goalSteps1 = 650000 * 10000
        let expiredDate1 = NSDate(timeInterval: 30 * 86400, since: NSDate() as Date)
        let image1 = UIImage.init(named: "World food organization")
        
        let charity1 = Charity(heldBy: company1, title: title1, caption: caption1, goalSteps: goalSteps1, expiredDate: expiredDate1, image: image1!)
        allCharities.append(charity1)
        
        let company2 = "Non-profit organization"
        let title2 = "Charity: water"
        let caption2 = "Charity: water is a non-profit organization bringing clean and safe drinking water to people in developing nations. \n To fund new freshwater wells, rainwater catchments and sand filters for African villages, we need $1,150,000."
        let goalSteps2 = 1150000 * 10000
        let expiredDate2 = NSDate(timeInterval: 30 * 86400, since: NSDate() as Date)
        let image2 = UIImage.init(named: "water charity")
        
        let charity2 = Charity(heldBy: company2, title: title2, caption: caption2, goalSteps: goalSteps2, expiredDate: expiredDate2, image: image2!)
        allCharities.append(charity2)
        
        let company3 = "Museum of Fine Arts, Boston"
        let title3 = "Museum of Fine Arts, Boston"
        let caption3 = "Help the Museum of Fine Arts to fund educational programs for contemporary artists who need financial assistance. \nTo develop their skills and talents, our program needs $300,000. "
        let goalSteps3 = 300000 * 10000
        let expiredDate3 = NSDate(timeInterval: 30 * 86400, since: NSDate() as Date)
        let image3 = UIImage.init(named: "Museum of fine arts")
        
        let charity3 = Charity(heldBy: company3, title: title3, caption: caption3, goalSteps: goalSteps3, expiredDate: expiredDate3, image: image3!)
        allCharities.append(charity3)
        
        let company4 = "IFAW"
        let title4 = "International fund for animal welfare"
        let caption4 = "IFAW’s mission is to rescue and protect animals around the world. \nWe rescue individuals, safeguard populations, and preserve habitat.\nYou rescue your steps and we will donate money for you."
        let goalSteps4 = 300000 * 10000
        let expiredDate4 = NSDate(timeInterval: 30 * 86400, since: NSDate() as Date)
        let image4 = UIImage.init(named: "IFAW")
        
        let charity4 = Charity(heldBy: company4, title: title4, caption: caption4, goalSteps: goalSteps4, expiredDate: expiredDate4, image: image4!)
        allCharities.append(charity4)

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
