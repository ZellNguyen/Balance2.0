//
//  MealPost.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

enum MealType: String {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
    case other = "Other"
}

class MealPost: NSObject, UserPost {
    var image: UIImage!
    var caption: String?
    var comments: CommentsList!
    var type: MealType
    var user: UserAccount!
    var date: NSDate!
    
    init( image: UIImage?, caption: String?, type: MealType, user: UserAccount, comments: CommentsList, date: NSDate ){
        self.image = image
        self.caption = caption
        self.type = type
        self.user = user
        self.comments = comments
        self.date = date
        
        super.init()
    }
    
    convenience init(image: UIImage?, caption: String?, type: MealType, user: UserAccount, comments: CommentsList) {
        self.init(image: image, caption: caption, type: type, user: user, comments: comments, date: NSDate())
    }
    
    convenience init( image: UIImage?, caption: String?, type: MealType, user: UserAccount ){
        let comments = CommentsList()
        self.init( image: image, caption: caption, type: type, user: user, comments: comments)
    }
    
    convenience init( image: UIImage?, caption: String?, type: MealType) {
        let user = ProfileManager.myProfile.myself
        self.init( image: image, caption: caption, type: type, user: user!)
    }
}
