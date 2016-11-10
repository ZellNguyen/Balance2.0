//
//  PostsList.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class PostsList {
    var allPosts = [Post]()
    
    init(){
        for _ in 0..<5 {
            let image = UIImage(named: "default-image-post")
            let friend = UserAccount(email: "hoazell41195@gmail.com", firstName: "Hoa")
            let post = MealPost(image: image, caption: "ABC", type: .breakfast, user: friend)
            
            allPosts.append(post)
        }
    }
    
    func add(_ post: Post){
        allPosts.append(post)
    }
}
