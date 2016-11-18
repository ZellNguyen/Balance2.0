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
    
    init(title: String, caption: String?, image: UIImage, comments: CommentsList, date: NSDate) {
        self.title = title
        self.caption = caption
        self.image = image
        self.comments = comments
        self.date = date
        super.init()
    }

    convenience init(title: String, caption: String?, image: UIImage, comments: CommentsList) {
        self.init(title: title, caption: caption, image: image, comments: comments, date: NSDate())
    }
    
    convenience init(title: String, caption: String?, image: UIImage){
        let comments = CommentsList()
        self.init(title: title, caption: caption, image: image, comments: comments)
    }
    
    convenience init(title: String, caption: String?){
        let image = UIImage.init(named: "default-image-post")
        self.init(title: title, caption: caption, image: image!)
    }
}
