//
//  IndividualExerciseChallenge.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-14.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class IndividualExerciseChallenge: NSObject, Challenge {
    
    var sender: UserAccount
    var receiver: UserAccount?
    var status: ChallengeStatus!
    var fromDate: Date!
    var toDate: Date!
    
    var myCurrentSteps: Int! = 0
    var friendCurrentSteps: Int! = 0
    
    var message: String!
    
    init(message: String!, sender: UserAccount, receiver: UserAccount?, status: ChallengeStatus, fromDate: Date!, toDate: Date, myCurrentSteps: Int, friendCurrentSteps: Int) {
        self.message = message

        self.sender = sender
        if let receiver = receiver {
            self.receiver = receiver
        }
        else {
            self.receiver = nil
        }
        self.status = status
        self.fromDate = fromDate
        self.toDate = toDate
        self.myCurrentSteps = myCurrentSteps
        self.friendCurrentSteps = friendCurrentSteps
        
        super.init()
    }
    
    convenience init(message: String, sender: UserAccount, receiver: UserAccount?, fromDate: Date, toDate: Date) {
        self.init(message: message, sender: sender, receiver: receiver, status: ChallengeStatus.pending, fromDate: fromDate, toDate: toDate, myCurrentSteps: 0, friendCurrentSteps: 0)
    }
}
