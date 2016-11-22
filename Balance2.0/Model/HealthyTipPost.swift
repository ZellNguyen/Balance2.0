//
//  HealthyTipPost.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-10.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class HealthyTipPost: NSObject, Post {
    var caption: String?
    var image: UIImage!
    var date: NSDate!
    
    var comments: CommentsList!
    var title: String!
    var likes: [UserAccount]
    
    init(title: String, caption: String?, image: UIImage, comments: CommentsList, likes: [UserAccount], date: NSDate) {
        self.title = title
        self.caption = caption
        self.image = image
        self.comments = comments
        self.date = date
        self.likes = likes
        super.init()
    }

    convenience init(title: String, caption: String?, image: UIImage, comments: CommentsList, likes: [UserAccount]) {
        self.init(title: title, caption: caption, image: image, comments: comments, likes: likes, date: NSDate())
    }
    
    convenience init(title: String, caption: String?, image: UIImage){
        let comments = CommentsList()
        let likes = [UserAccount]()
        self.init(title: title, caption: caption, image: image, comments: comments, likes: likes)
    }
    
    convenience init(title: String, caption: String?){
        let image = UIImage.init(named: "default-image-post")
        self.init(title: title, caption: caption, image: image!)
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
