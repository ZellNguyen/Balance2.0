//
//  Comment.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-09.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class Comment: NSObject {
    var user: UserAccount!
    var content: String!
    var datePosted: NSDate!

    init(by user: UserAccount, withContent content: String, datePosted: NSDate!) {
        self.user = user
        self.content = content
        self.datePosted = datePosted
        super.init()
    }
    
    convenience init(by user: UserAccount, withContent content: String) {
        let date = NSDate()
        self.init(by: user, withContent: content, datePosted: date)
    }
    
    convenience init(withContent content: String){
        let friend = UserAccount(email: "hoazell41195@gmail.com", fullName: "Hoa")
        self.init(by: friend, withContent: content)
    }
}
