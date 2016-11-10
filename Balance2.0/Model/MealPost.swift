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

class MealPost: NSObject, Post {
    var image: UIImage?
    var caption: String?
    var comments: CommentsList
    var type: MealType
    var user: UserAccount
    var date: NSDate {
        return NSDate()
    }
    
    init( image: UIImage?, caption: String?, type: MealType, user: UserAccount, comments: CommentsList ){
        self.image = image
        self.caption = caption
        self.type = type
        self.user = user
        self.comments = comments
        
        super.init()
    }
    
    convenience init( image: UIImage?, caption: String?, type: MealType, user: UserAccount ){
        let comments = CommentsList()
        self.init( image: image, caption: caption, type: type, user: user, comments: comments)
    }
}
