//
//  FriendList.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class FriendList: NSObject, NSCoding {
    var allFriends = [UserAccount]()
    
    override init() {
        super.init()
        let charles = UserAccount(email: "charles@gmail.com", fullName: "Charles")
        charles.profile.dailySteps = 28345
        charles.profile.weeklySteps = 85035
        charles.profile.monthlySteps = 330140
        charles.profile.picture = UIImage.init(named: "Charles 1")
        self.add(friend: charles)
        
        let maria = UserAccount(email: "maria@gmail.com", fullName: "Maria")
        maria.profile.dailySteps = 25670
        maria.profile.weeklySteps = 115340
        maria.profile.monthlySteps = 350400
        maria.profile.picture = UIImage.init(named: "Maria 1")
        self.add(friend: maria)
        
        let jacob = UserAccount(email: "jacob@gmail.com", fullName: "Jacob")
        jacob.profile.dailySteps = 2200
        jacob.profile.weeklySteps = 88000
        jacob.profile.monthlySteps = 350900
        jacob.profile.picture = UIImage.init(named: "Jacob 1")
        self.add(friend: jacob)
        
        let julia = UserAccount(email: "julia@gmail.com", fullName: "Julia")
        julia.profile.dailySteps = 21300
        julia.profile.weeklySteps = 106500
        julia.profile.monthlySteps = 389000
        julia.profile.picture = UIImage.init(named: "Julia 1")
        self.add(friend: julia)
    }
    
    required convenience init(coder decoder: NSCoder){
        self.init()
        self.allFriends = decoder.decodeObject(forKey: "allFriends") as! [UserAccount]
    }
    
    func add(friend user: UserAccount) {
        allFriends.append(user)
    }
    
    func getFriend(atIndex index: Int) -> UserAccount?{
        return index < allFriends.count ? allFriends[index] : nil
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(allFriends, forKey: "allFriends")
    }
}
