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
    
    func add(_ post: Post){
        allPosts.insert(post, at: 0)
        
        if let post = post as? MealPost {
            PostsList.meals.allPosts.insert(post, at: 0)
        }
        if let post = post as? CharityPost {
            PostsList.charities.allPosts.insert(post, at: 0)
        }
        if let post = post as? MealChallengePost {
            PostsList.mealChallenges.allPosts.insert(post, at: 0)
        }
    }
    
    func loadData(){
        for i in 0..<3 {
            let imageName = "Meal\(i+1)"
            let image = UIImage(named: imageName)
            let user = ProfileManager.myProfile.myself
            let tags = FoodTagList()
            var random = Int(arc4random_uniform(10))
            tags.add(tag: FoodTagList.main.foodTags[random].instantiate())
            random = Int(arc4random_uniform(10))
            tags.add(tag: FoodTagList.main.foodTags[random].instantiate())
            FoodTagList.logged.add(tags: tags)
            if user != nil {
                let post = MealPost(image: image, caption: "", type: .breakfast, tags: tags, user: user!)
                switch i {
                case 0:
                    post.comments.add(comment: Comment(by: ProfileManager.myProfile.friendList.allFriends[0], withContent: "mmm … so yummy…hey, Alice, did you add mayo to havemake the drumsticks crispy"))
                    post.comments.add(comment: Comment(by: ProfileManager.myProfile.friendList.allFriends[1], withContent: "Maria, of course not! just grill regime it in your oven for 5 minutes before taking drumsticks out and it will stay crispy and tasty"))
                case 1:
                    post.comments.add(comment: Comment(by: ProfileManager.myProfile.friendList.allFriends[3], withContent: "looks like an extremely healthy dinner and low in calories"))
                    post.comments.add(comment: Comment(by: ProfileManager.myProfile.myself, withContent: "looks like an extremely healthy dinner and low in calories"))
                    post.comments.add(comment: Comment(by: ProfileManager.myProfile.friendList.allFriends[3], withContent: "I feel like it is hard to cook it, won’t motivate myself"))
                case 2:
                    post.comments.add(comment: Comment(by: ProfileManager.myProfile.friendList.allFriends[0], withContent: "nuts, oat and fruits…will you change your breakfast one day?"))
                    post.comments.add(comment: Comment(by: ProfileManager.myProfile.myself, withContent: "Nope"))
                default:
                    break
                }
                
                
                self.add(post)
            }
        }
        
        let healthyPost1 = HealthyTipPost(title: "Limit your intake of foods full of saturated fats, trans fats, and dietary cholesterol.", caption: "Best Choice: Omega-3-rich fish, such as salmon, sardines, herring, mackerel, and trout. Choose at least 2 times weekly. If you’re using canned fish, such as canned sardines, select very-low-sodium or no-salt-added varieties. \n Good Choice: Most other fish, plus shelled mollusks (clams, oysters, mussels, scallops). \nSatisfactory Choices: Crustaceans (shrimp, crab, lobster, crawfish), Poultry (white meat, skinless) Game Meat (bison, venison, elk, ostrich), optimally free-range and grass-fed \nPoor Choice: Red meat (beef, pork, lamb, veal, goat). For all red meat choices, select cuts that are under 30% fat.", image: UIImage.init(named: "low-cholesterol-diet-foods")!, link: "http://andreadelrio.me/health-tip/")
        
        self.add(healthyPost1)
        
        let healthyPost2 = HealthyTipPost(title: "Did you know that the same food can be both healthy and harmful?", caption: "Excellent sources include: oats, oat bran, barley, peas, yams, sweet potatoes and other potatoes, as well as legumes or beans, such as pinto beans, black beans, garbanzo beans, and peas. \n Vegetables rich in soluble fiber include: carrots, Brussels sprouts, beets, okra, and eggplant. Good fruit sources are berries, passion fruit, oranges, pears, apricots, nectarines, and apples." , image: UIImage.init(named: "Low_Cholesterol_logo")!, link: "http://hexagonbalance.weebly.com/timings-for-food.html")
        
        self.add(healthyPost2)
        
        let charityList = CharityList()
        for charity in charityList.allCharities{
            let image = charity.image
            let random = Int(arc4random_uniform(4))
            let post = CharityPost(user: ProfileManager.myProfile.friendList.allFriends[random], charity: charity, image: image!, caption: charity.caption)
            
            self.add(post)
        }
        
        let challenge1 = IndividualMealChallenge(title: "No meat day", message: "Let's see who is healthier", post: PostsList.meals.allPosts[0] as! MealPost, fromDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, toDate: Date(), sender: ProfileManager.myProfile.friendList.allFriends[0], receiver: ProfileManager.myProfile.myself, option: MealChallengeOption.no_meat, status: ChallengeStatus.finished, link: nil)
        let challenge2 = IndividualMealChallenge(title: "No meat day", message: "Let's see who is healthier", post: PostsList.meals.allPosts[01] as! MealPost, fromDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, toDate: Date(), sender: ProfileManager.myProfile.friendList.allFriends[0], receiver: ProfileManager.myProfile.myself, option: MealChallengeOption.no_meat, status: ChallengeStatus.finished, link: nil)
        let challengePost = MealChallengePost(caption: "Let's see who is healthier", date: Date(), isReady: true, mealChallenge: [challenge1, challenge2])
        self.add(challengePost)
    }
    
    static var hidden = PostsList()
    
    static var main: PostsList = {
        let list = PostsList()
        
        list.loadData()
        return list
    }()
    
    static var meals: PostsList = PostsList()
    
    static var charities: PostsList = PostsList()
    
    static var mealChallenges: PostsList = PostsList()

    func like(atPost index: Int) {
        if let post = self.allPosts[index] as? MealPost {
            post.like()
            return
        }
        if let post = self.allPosts[index] as? CharityPost {
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
        if let post = self.allPosts[index] as? CharityPost {
            post.unlike()
        }
        if let post = self.allPosts[index] as? HealthyTipPost {
            post.unlike()
        }
    }

}
