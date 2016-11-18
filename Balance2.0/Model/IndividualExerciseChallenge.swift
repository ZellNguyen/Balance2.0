//
//  IndividualExerciseChallenge.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-14.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class IndividualExerciseChallenge: NSObject, Challenge {
    
    var title: String!
    var date: NSDate!
    var image: UIImage!
    var receiver: UserAccount?
    var status: ChallengeStatus!
    var deadline: NSDate!
    var isWinner: Bool! = false
    
    var message: String!
    var goalSteps: Int!
    var currentSteps: Int!
    
    init(title: String!, image: UIImage!, message: String!, goalSteps: Int!, currentSteps: Int!, receiver: UserAccount?, status: ChallengeStatus, date: NSDate!, deadline: NSDate, isWinner: Bool) {
        super.init()
        
        self.title = title
        self.image = image
        self.message = message
        self.goalSteps = goalSteps
        self.currentSteps = currentSteps
        
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
    }
    
    convenience init(title: String!, image: UIImage!, message: String!, goalSteps: Int!, currentSteps: Int!, receiver: UserAccount?, status: ChallengeStatus, deadline: NSDate, isWinner: Bool) {
        let date = NSDate()
        self.init(title: title, image: image, message: message, goalSteps: goalSteps, currentSteps: currentSteps, receiver: receiver, status: status, date: date, deadline: deadline, isWinner: isWinner)
    }
    
    convenience init(title: String!, image: UIImage!, message: String!, goalSteps: Int!, currentSteps: Int!, receiver: UserAccount?, status: ChallengeStatus, deadline: NSDate){
        self.init(title: title, image: image, message: message, goalSteps: goalSteps, currentSteps: currentSteps, receiver: receiver, status: status, deadline: deadline, isWinner: false)
    }
    
    convenience init(title: String!, image: UIImage!, message: String!, goalSteps: Int!, receiver: UserAccount?, deadline: NSDate){
        self.init(title: title, image: image, message: message, goalSteps: goalSteps, currentSteps: 0, receiver: receiver, status: ChallengeStatus.pending, deadline: deadline)
    }
    
    convenience init(title: String!, image: UIImage, goalSteps: Int!, deadline: NSDate){
        self.init(title: title, image: image, message: "", goalSteps: goalSteps, receiver: nil, deadline: deadline)
    }
    
    convenience init(title: String!, goalSteps: Int!, deadline: NSDate){
        let image = UIImage.init(named: "default-image-post")
        self.init(title: title, image: image!, goalSteps: goalSteps, deadline: deadline)
    }
    
    convenience init(title: String!, message: String!, goalSteps: Int!, receiver: UserAccount!, deadline: NSDate!) {
        let image = UIImage.init(named: "default-image-post")
        self.init(title: title, image: image, message: message, goalSteps: goalSteps, receiver: receiver, deadline: deadline)
    }
    
    // MARK: Encoding
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
        aCoder.encode(goalSteps, forKey: "goalSteps")
        aCoder.encode(currentSteps, forKey: "currentSteps")
    }
    
    // MARK: Decoding
    convenience required init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! NSDate
        let image = aDecoder.decodeObject(forKey: "image") as! UIImage
        let receiver = aDecoder.decodeObject(forKey: "receiver") as! UserAccount
        let status = ChallengeStatus(rawValue: aDecoder.decodeObject(forKey: "status") as! String)
        let deadline = aDecoder.decodeObject(forKey: "deadline") as! NSDate
        let isWinner = aDecoder.decodeObject(forKey: "isWinner") as! Bool
        let message = aDecoder.decodeObject(forKey: "message") as! String
        let goalSteps = aDecoder.decodeObject(forKey: "goalSteps") as! Int
        let currentSteps = aDecoder.decodeObject(forKey: "currentSteps") as! Int
        
        self.init(title: title, image: image, message: message, goalSteps: goalSteps, currentSteps: currentSteps, receiver: receiver, status: status!, date: date, deadline: deadline, isWinner: isWinner)
    }
}
