//
//  CharityPost.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class CharityPost: NSObject, UserPost {
    var image: UIImage!
    var caption: String?
    var comments: CommentsList! 
    var user: UserAccount!
    
    var date: NSDate!
    
    var charity: Charity!
    
    init(user: UserAccount, charity: Charity, image: UIImage, caption: String?, comments: CommentsList, date: NSDate){
        super.init()
        
        self.user = user
        self.charity = charity
        self.image = image
        self.caption = caption
        self.comments = comments
        self.date = date
    }
    
    convenience init(user: UserAccount, charity: Charity, image: UIImage, caption: String?, comments: CommentsList) {
        self.init(user: user, charity: charity, image: image, caption: caption, comments: comments, date: NSDate())
    }
    
    convenience init(charity: Charity, image: UIImage, caption: String?){
        let friend = UserAccount(email: "hoazell41195@gmail.com", fullName: "Hoa")
        let comments = CommentsList()
        
        self.init(user: friend, charity: charity, image: image, caption: caption, comments: comments)
    }
    
    convenience init(charity: Charity, image: UIImage){
        let caption = charity.caption
        self.init(charity: charity, image: image, caption: caption)
    }
    
    convenience init(charity: Charity){
        let image = charity.image
        self.init(charity: charity, image: image!)
    }
}
