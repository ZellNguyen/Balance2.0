//
//  PostsList.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class PostsList {
    var allPosts: [Post] = [Post]()
    
    init(){
        self.loadData()
    }
    
    func add(_ post: Post){
        allPosts.insert(post, at: 0)
    }
    
    func loadData(){
        for _ in 0..<5 {
            let image = UIImage(named: "default-image-post")
            let friend = UserAccount(email: "hoazell41195@gmail.com", fullName: "Hoa")
            let post = MealPost(image: image, caption: "ABC", type: .breakfast, tags: FoodTagList.main, user: friend)
            
            self.add(post)
        }
        
        for _ in 0..<5 {
            let post = HealthyTipPost(title: "Eat More Vegetables", caption: "Eating more vegetables helps you look more handsome")
            
            self.add(post)
        }
        
        for i in 0..<5 {
            let charityList = CharityList()
            let charity = charityList.allCharities[i]
            let image = UIImage(named: "default-image-post")
            let post = CharityPost(charity: charity, image: image!)
            
            self.add(post)
        }
    }
    
    static var main = PostsList()

    func like(atPost index: Int) {
        if let post = self.allPosts[index] as? MealPost {
            post.like()
            return
        }
        if let post = self.allPosts[index] as? ExercisePost {
            post.like()
        }
        if let post = self.allPosts[index] as? HealthyTipPost {
            post.like()
        }
    }
    
    func unlike(atPost index: Int){
        if let post = self.allPosts[index] as? MealPost {
            post.unlike()
            return
        }
        if let post = self.allPosts[index] as? ExercisePost {
            post.unlike()
        }
        if let post = self.allPosts[index] as? HealthyTipPost {
            post.unlike()
        }
    }
}
