//
//  ExerciseChallengePost.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-19.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class ExerciseChallengePost: NSObject, Post {
    var caption: String?
    var date: NSDate!
    var comments: CommentsList!
    var image: UIImage
    var likes: [UserAccount]

    init(caption: String, image: UIImage, date: NSDate, comments: CommentsList, likes: [UserAccount]) {
        self.caption = caption
        self.image = image
        self.date = date
        self.comments = comments
        self.likes = likes
        
        super.init()
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
