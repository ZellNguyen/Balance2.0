//
//  UserAccount.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {
    var email: String!
    var fullName: String!
    var facebook: String?
    var profile: UserProfile!
    
    init( email: String, fullName: String, facebook: String?, profile: UserProfile ) {
        self.email = email
        self.fullName = fullName
        self.facebook = facebook
        self.profile = profile
        
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let email = aDecoder.decodeObject(forKey: "email") as! String!
        let fullName = aDecoder.decodeObject(forKey: "fullName") as! String!
        let facebook = aDecoder.decodeObject(forKey: "facebook") as! String?
        let profile = aDecoder.decodeObject(forKey: "profile") as! UserProfile!
        self.init(email: email!, fullName: fullName!, facebook: facebook, profile: profile!)
    }
    
    convenience init( email: String, fullName: String ){
        let profile = UserProfile()
        self.init( email: email, fullName: fullName, facebook: nil, profile: profile)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(fullName, forKey: "fullName")
        if let facebook = self.facebook {
            aCoder.encode(facebook, forKey: "facebook")
        }
        aCoder.encode(profile, forKey: "profile")
    }

}
