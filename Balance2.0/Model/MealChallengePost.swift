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
    var date: NSDate!
    var comments: CommentsList!
    var mealChallenge: [IndividualMealChallenge]
    
    init(caption: String, date: NSDate, mealChallenge: [IndividualMealChallenge]){
        self.caption = caption
        self.date = date
        self.mealChallenge = mealChallenge
        super.init()
    }
    
    func like(forPostIndex index: Int) {
        if mealChallenge.count == 0 {
            return
        }
        
        mealChallenge[index].like()
    }
    
    func unlike(forPostIndex index: Int) {
        if mealChallenge.count == 0 {
            return
        }
        
        mealChallenge[index].unlike()
    }
}
