//
//  UserAccount.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    var email: String!
    var firstName: String!
    var lastName: String?
    var facebook: String?
    
    var fullName: String {
        if let lastName = self.lastName {
            return "\(firstName) \(lastName)"
        }
        else {
            return "\(firstName)"
        }
    }
    
    init( email: String, firstName: String, lastName: String?, facebook: String? ) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.facebook = facebook
        
        super.init()
    }
    
    convenience init( email: String, firstName: String ){
        self.init( email: email, firstName: firstName, lastName: nil, facebook: nil)
    }
    
}
