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
        for _ in 0..<5 {
            let user = UserAccount(email: "hoa4124@gmail.com", fullName: "Hoa")
            self.add(friend: user)
        }
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
