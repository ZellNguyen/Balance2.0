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
    var message: String!
    var image: UIImage!
    var status: ChallengeStatus!
    var fromDate: Date!
    var toDate: Date!
    var sender: UserAccount
    var receiver: UserAccount?
    var option: MealChallengeOption!
    var likes: [UserAccount]!
    
    init(message: String, image: UIImage, fromDate: Date, toDate: Date, sender: UserAccount, receiver: UserAccount, option: MealChallengeOption, likes: [UserAccount]) {
        self.message = message
        self.image = image
        self.fromDate = fromDate
        self.toDate = toDate
        self.sender = sender
        self.receiver = receiver
        self.option = option
        self.likes = likes
        
        super.init()
    }
    
    // MARK: Like & Unlike
    func like() {
        self.likes.append(ProfileManager.myProfile.myself)
    }
    
    func unlike(){
        let index = self.likes.index(of: ProfileManager.myProfile.myself)
        if let _ = index {
            self.likes.remove(at: index!)
        }
    }
}
