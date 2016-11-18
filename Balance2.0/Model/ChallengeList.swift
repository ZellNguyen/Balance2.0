//
//  ChallengeList.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-15.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class ChallengeList {
    var allChallenges: [Challenge]! = [Challenge]()
    
    func add(challenge: Challenge) {
        self.allChallenges.insert(challenge, at: 0)
    }
    
    static var exerciseChallengeList = ChallengeList()
    static var mealChallengeList = ChallengeList()
}
