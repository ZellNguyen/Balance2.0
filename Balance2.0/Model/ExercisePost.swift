//
//  ExercisePost.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-10.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class ExercisePost: NSObject, UserPost {
    var image: UIImage!
    var caption: String?
    var date: NSDate!
    var user: UserAccount!
    var comments: CommentsList!
    var steps: Int
    
    init(by user: UserAccount, image: UIImage?, caption: String?, comments: CommentsList, steps: Int, date: NSDate){
        self.image = image
        self.caption = caption
        self.user = user
        self.comments = comments
        self.steps = steps
        self.date = date
        super.init()
    }
    
    convenience init(by user: UserAccount, image: UIImage?, caption: String?, comments: CommentsList, steps: Int) {
        self.init(by: user, image: image, caption: caption , comments: comments, steps: steps, date: NSDate())
    }
    
    convenience init(by user: UserAccount, image: UIImage?, caption: String?, steps: Int){
        let comments = CommentsList()
        self.init(by: user, image: image, caption: caption, comments: comments, steps: steps)
    }
    
    convenience init(image: UIImage?, caption: String?, steps: Int){
        let friend = UserAccount(email: "hoazell41195@gmail.com", fullName: "Hoa")
        self.init(by: friend, image: image, caption: caption, steps: steps)
    }
    
    convenience init(caption: String?, steps: Int) {
        let image = UIImage.init(named: "default-image-post")
        self.init(image: image, caption: caption, steps: steps)
    }
    
}
