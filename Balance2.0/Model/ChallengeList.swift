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
    
    static var exerciseChallengeList: ChallengeList = {
        let list = ChallengeList()
        
        for friend in ProfileManager.myProfile.friendList.allFriends {
            let sender = friend
            let receiver = ProfileManager.myProfile.myself
            let fromDate = Date()
            let toDate = Calendar.current.date(byAdding: .day, value: 2, to: Date())
            let senderSteps = 8000 + arc4random_uniform(5000)
            let receiverSteps = 12000 + arc4random_uniform(2000)
            
            let challenge = IndividualExerciseChallenge(message: "Kick my ass", sender: sender, receiver: receiver, status: ChallengeStatus.active, fromDate: fromDate, toDate: toDate!, myCurrentSteps: Int(receiverSteps), friendCurrentSteps: Int(senderSteps))
            list.add(challenge: challenge)
        }
        
        
        let sender1 = ProfileManager.myProfile.friendList.allFriends[0]
        let receiver1 = ProfileManager.myProfile.myself
        
        let fromDate1 = Calendar.current.date(byAdding: .day, value: 9, to: Date())
        let toDate1 = Calendar.current.date(byAdding: .day, value: 7, to: fromDate1!)
        let message1 = "Alice, new challenge 15000 steps in total. I'm here to beat you"
        
        let challenge1 = IndividualExerciseChallenge(message: message1, sender: sender1, receiver: receiver1, fromDate: fromDate1!, toDate: toDate1!)
        list.add(challenge: challenge1)
        
        let sender2 = ProfileManager.myProfile.friendList.allFriends[1]
        let receiver2 = ProfileManager.myProfile.myself
        
        let fromDate2 = Calendar.current.date(byAdding: .day, value: 5, to: Date())
        let toDate2 = Calendar.current.date(byAdding: .day, value: 5, to: fromDate2!)
        let message2 = "Alice, can you accomplish 120000 steps. Let's see who wins"
        
        let challenge2 = IndividualExerciseChallenge(message: message2, sender: sender2, receiver: receiver2, fromDate: fromDate2!, toDate: toDate2!)
        list.add(challenge: challenge2)
        
        return list
    }()
    
    static var mealChallengeList: ChallengeList = {
        let list = ChallengeList()
        
        let title1 = "No meat day"
        let message1 = "Let's not eat meat"
        let sender1 = ProfileManager.myProfile.friendList.allFriends[0]
        let receiver1 = ProfileManager.myProfile.myself
        let fromDate1 = Date()
        let toDate1 = Calendar.current.date(byAdding: .day, value: 2, to: Date())
        
        let post1 = MealPost(image: UIImage.init(named: "Meal3"), caption: "Salad", type: .lunch, tags: FoodTagList())
        
        let challenge1 = IndividualMealChallenge(title: title1, message: message1, post: post1, fromDate: fromDate1, toDate: toDate1!, sender: sender1, receiver: receiver1!, option: MealChallengeOption.no_meat, status: ChallengeStatus.active)
        list.add(challenge: challenge1)
        let challengePost1 = MealChallengePost(caption: title1, date: fromDate1, isReady: false, mealChallenge: [challenge1])
        PostsList.main.add(challengePost1)
        
        return list
    }()
    
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
