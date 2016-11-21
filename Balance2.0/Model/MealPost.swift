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
    var likes: [UserAccount]
    var tags: FoodTagList
    
    init( image: UIImage?, caption: String?, type: MealType, tags: FoodTagList, user: UserAccount, comments: CommentsList, date: NSDate, likes: [UserAccount]){
        self.image = image
        self.caption = caption
        self.type = type
        self.user = user
        self.comments = comments
        self.date = date
        self.likes = likes
        self.tags = tags
        
        super.init()
    }
    
    convenience init(image: UIImage?, caption: String?, type: MealType, tags: FoodTagList, user: UserAccount, comments: CommentsList, likes: [UserAccount]) {
        self.init(image: image, caption: caption, type: type, tags: tags, user: user, comments: comments, date: NSDate(), likes: likes)
    }
    
    convenience init( image: UIImage?, caption: String?, type: MealType, tags: FoodTagList, user: UserAccount ){
        let comments = CommentsList()
        let likes = [UserAccount]()
        self.init( image: image, caption: caption, type: type, tags: tags, user: user, comments: comments, likes: likes)
    }
    
    convenience init( image: UIImage?, caption: String?, type: MealType, tags: FoodTagList) {
        let user = ProfileManager.myProfile.myself
        self.init( image: image, caption: caption, type: type, tags: tags, user: user!)
    }
    
    func like() {
        self.likes.append(ProfileManager.myProfile.myself)
    }
    
    func unlike() {
        let index = self.likes.index(of: ProfileManager.myProfile.myself)
        if let _ = index {
            self.likes.remove(at: index!)
        }
    }
}
