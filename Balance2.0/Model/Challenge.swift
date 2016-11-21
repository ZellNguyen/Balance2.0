//
//  Challenge.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-14.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

enum ChallengeStatus: String {
    case pending
    case active
    case finished
    case expired
    case finishedVoting
}

protocol Challenge: class, NSCoding {
    var title: String! { get set }
    var date: NSDate! { get }
    var message: String! { get set }
    var image: UIImage! { get set }
    var sender: UserAccount { get set }
    var receiver: UserAccount? { get set }
    var status: ChallengeStatus! { get set }
    var deadline: NSDate! { get set }
    var isWinner: Bool! { get set }
}
