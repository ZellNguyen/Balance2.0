//
//  MealChallengePost.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-19.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class MealChallengePost: NSObject, Post {
    var caption: String?
    var date: Date!
    var comments: CommentsList!
    var isReady: Bool
    var mealChallenge: [IndividualMealChallenge]
    
    init(caption: String, date: Date, isReady: Bool, mealChallenge: [IndividualMealChallenge]){
        self.caption = caption
        self.date = date
        self.isReady = isReady
        self.mealChallenge = mealChallenge
        self.comments = CommentsList()
        super.init()
    }
}
