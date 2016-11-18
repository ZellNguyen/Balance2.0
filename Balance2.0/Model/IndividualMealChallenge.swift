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
    
    
    static var no_meat = MealChallengeOption(name: "No Meat", image: UIImage.init(named: "default-image-post"))
    static var salad = MealChallengeOption(name: "Salad", image: UIImage.init(named: "default-image-post"))

}

class IndividualMealChallenge: NSObject, Challenge {
    var title: String!
    var date: NSDate!
    var message: String!
    var image: UIImage!
    var status: ChallengeStatus!
    var deadline: NSDate!
    var receiver: UserAccount?
    var isWinner: Bool! = false
    var option: MealChallengeOption!
    var likes: [UserAccount]!
    
    init(title: String!, message: String!, image: UIImage!, receiver: UserAccount?, status: ChallengeStatus, date: NSDate!, deadline: NSDate!, isWinner: Bool!, option: MealChallengeOption, likes: [UserAccount]!) {
        super.init()
        self.title = title
        self.message = message
        self.image = image
        if let receiver = receiver {
            self.receiver = receiver
        }
        else {
            self.receiver = nil
        }
        self.status = status
        self.date = date
        self.deadline = deadline
        self.isWinner = isWinner
        self.option = option
        self.likes = likes
    }
    
    convenience init(title: String!, message: String!, image: UIImage!, receiver: UserAccount?, deadline: NSDate!, option: MealChallengeOption){
        let date = NSDate()
        let isWinner = false
        let status = ChallengeStatus.pending
        let likes = [UserAccount]()
        
        self.init(title: title, message: message, image: image, receiver: receiver, status: status, date: date, deadline: deadline, isWinner: isWinner, option: option, likes: likes)
    }
    
    convenience init(title: String!, image: UIImage!, deadline: NSDate!, option: MealChallengeOption){
        self.init(title: title, message: "", image: image, receiver: nil, deadline: deadline, option: option)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(image, forKey: "image")
        if let _ = receiver {
            aCoder.encode(receiver, forKey: "receiver")
        }
        aCoder.encode(status.rawValue, forKey: "status")
        aCoder.encode(deadline, forKey: "deadline")
        aCoder.encode(isWinner, forKey: "isWinner")
        aCoder.encode(message, forKey: "message")
        aCoder.encode(option, forKey: "option")
        aCoder.encode(likes, forKey: "likes")
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! NSDate
        let image = aDecoder.decodeObject(forKey: "image") as! UIImage
        let receiver = aDecoder.decodeObject(forKey: "receiver") as! UserAccount
        let status = ChallengeStatus(rawValue: aDecoder.decodeObject(forKey: "status") as! String)
        let deadline = aDecoder.decodeObject(forKey: "deadline") as! NSDate
        let isWinner = aDecoder.decodeObject(forKey: "isWinner") as! Bool
        let message = aDecoder.decodeObject(forKey: "message") as! String
        let option = aDecoder.decodeObject(forKey: "option") as! MealChallengeOption
        let likes = aDecoder.decodeObject(forKey: "likes") as! [UserAccount]
        
        self.init(title: title, message: message, image: image, receiver: receiver, status: status!, date: date, deadline: deadline, isWinner: isWinner, option: option, likes: likes)
    }
}
