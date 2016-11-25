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
    
    func loadProgress(){
        if let challenges = self.allChallenges as? [IndividualExerciseChallenge] {
            for challenge in challenges {
                if challenge.status == ChallengeStatus.active {
                    
                    // Start Add Steps into Challenge
                    StepCounter.main.authorizeHealthKit(completion: { (success, error) -> Void in
                        if success {
                            print("HealthKit authorization succeeded")
                            StepCounter.main.countSteps(from: challenge.fromDate, to: challenge.toDate, completion: { (steps, error) -> Void in
                                
                                challenge.myCurrentSteps = Int(steps)
                                
                                if error != nil {
                                    print("CANNOT AUTHORIZE")
                                }
                            })
                        }
                        else {
                            if error != nil {
                                print("CANNOT AUTHORIZE")
                            }
                        }
                    })
                    
                }
            }
        }
    }
}
