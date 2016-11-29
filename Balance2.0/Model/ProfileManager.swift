//
//  ProfileManager.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-13.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class ProfileManager {
    var myself: UserAccount!
    lazy var friendList: FriendList! = FriendList()
    var profile: UserProfile!
    
    func register( email: String, fullName: String ) {
        self.myself = UserAccount(email: email, fullName: fullName)
        self.friendList = FriendList()
        self.profile = UserProfile()
    }
    
    func login( email: String, fullName: String, friendList: FriendList, profile: UserProfile){
        self.myself = UserAccount(email: email, fullName: fullName)
        self.friendList = friendList
        self.profile = profile
    }
    
    func add(friend user: UserAccount){
        self.friendList.add(friend: user)
    }
    
    static var myProfile = ProfileManager()
}
