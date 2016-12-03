//
//  IndividualMealChallenge.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-14.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

struct MealChallengeOption {
    var name: String!
    var image: UIImage!
    
    
    static var no_meat = MealChallengeOption(name: "No meat day", image: UIImage.init(named: "default-image-post"))
    static var salad = MealChallengeOption(name: "Salad day", image: UIImage.init(named: "default-image-post"))
    static var no_cheese_day = MealChallengeOption(name: "No cheese day", image: UIImage.init(named: "default-image-post"))

    static var detox_day = MealChallengeOption(name: "Detox Day", image: UIImage.init(named: "default-image-post"))
    static var organic_day = MealChallengeOption(name: "Organic Food Day", image: UIImage.init(named: "default-image-post"))
    static var vegetarian = MealChallengeOption(name: "Vegetarian day", image: UIImage.init(named: "default-image-post"))
    static var leaflyVeggies = MealChallengeOption(name: "Leafly veggies day", image: UIImage.init(named: "default-image-post"))
    static var blackBox = MealChallengeOption(name: "BlackBox", image: UIImage.init(named: "default-image-post"))
}

class IndividualMealChallenge: NSObject, Challenge, NSCopying {
    var title: String!
    var message: String!
    var status: ChallengeStatus!
    var fromDate: Date!
    var toDate: Date!
    var sender: UserAccount
    var receiver: UserAccount?
    var option: MealChallengeOption!
    var post: MealPost? = nil
    var link: String? = nil
    
    init(title: String, message: String, post: MealPost, fromDate: Date, toDate: Date, sender: UserAccount, receiver: UserAccount, option: MealChallengeOption, status: ChallengeStatus, link: String?) {
        self.title = title
        self.message = message
        self.post = post
        self.fromDate = fromDate
        self.toDate = toDate
        self.sender = sender
        self.receiver = receiver
        self.option = option
        self.status = status
        self.link = link
        super.init()
    }
    
    convenience init(title: String, message: String, fromDate: Date, toDate: Date, receiver: UserAccount, option: MealChallengeOption, link: String?){
        let post = MealPost()
        self.init(title: title, message: message, post: post, fromDate: fromDate, toDate: toDate, sender: ProfileManager.myProfile.myself, receiver: receiver, option: option, status: .pending, link: link)
    }
    
    override func copy() -> Any {
        return IndividualMealChallenge(title: self.title, message: self.message, fromDate: self.fromDate, toDate: self.toDate, receiver: self.receiver!, option: self.option, link: self.link!)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return IndividualMealChallenge(title: self.title, message: self.message, fromDate: self.fromDate, toDate: self.toDate, receiver: self.receiver!, option: self.option, link: self.link!)
    }
}
