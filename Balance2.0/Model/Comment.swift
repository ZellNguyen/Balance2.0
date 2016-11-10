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
    var datePosted: NSDate {
        return NSDate()
    }

    init(by user: UserAccount, withContent content: String) {
        self.user = user
        self.content = content
        super.init()
    }
    
    convenience init(withContent content: String){
        self.init(by: FriendList.myself, withContent: content)
    }
}
