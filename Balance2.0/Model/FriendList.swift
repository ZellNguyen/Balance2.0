//
//  FriendList.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class FriendList {
    var allFriends = [UserAccount]()
    static var myself = UserAccount(email: "hoadnguyen411@gmail.com", firstName: "hoazell")
    
    init() {
        for _ in 0..<5 {
            let user = UserAccount(email: "hoazell41195@gmail.com", firstName: "Hoa")
            self.add(friend: user)
        }
    }
    
    func add(friend user: UserAccount) {
        allFriends.append(user)
    }
    
    func getFriend(atIndex index: Int) -> UserAccount?{
        return index < allFriends.count ? allFriends[index] : nil
    }
}
