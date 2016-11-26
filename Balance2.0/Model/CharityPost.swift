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
    
    var date: Date!
    
    var charity: Charity!
    
    var likes: [UserAccount]
    
    init(user: UserAccount, charity: Charity, image: UIImage, caption: String?, comments: CommentsList, date: Date, likes: [UserAccount]){
        self.user = user
        self.charity = charity
        self.image = image
        self.caption = caption
        self.comments = comments
        self.date = date
        self.likes = likes
        
        super.init()
    }
    
    convenience init(user: UserAccount, charity: Charity, image: UIImage, caption: String?, comments: CommentsList, likes: [UserAccount]) {
        self.init(user: user, charity: charity, image: image, caption: caption, comments: comments, date: Date(), likes: likes)
    }
    
    convenience init(user: UserAccount, charity: Charity, image: UIImage, caption: String?) {
        let comments = CommentsList()
        let likes = [UserAccount]()
        self.init(user: user, charity: charity, image: image, caption: caption, comments: comments, likes: likes)
    }
    
    convenience init(charity: Charity, image: UIImage, caption: String?){
        let friend = ProfileManager.myProfile.myself
        let comments = CommentsList()
        let likes = [UserAccount]()
        
        self.init(user: friend!, charity: charity, image: image, caption: caption, comments: comments, likes: likes)
    }
    
    convenience init(charity: Charity, image: UIImage){
        let caption = charity.caption
        self.init(charity: charity, image: image, caption: caption)
    }
    
    convenience init(charity: Charity){
        let image = charity.image
        self.init(charity: charity, image: image!)
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
