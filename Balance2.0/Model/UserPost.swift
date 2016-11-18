//
//  UserPost.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-10.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

protocol UserPost: Post {
    var image: UIImage! { get set }
    var caption: String? { get set }
    var date: NSDate! { get set }
    var comments: CommentsList! { get set }
    var user: UserAccount! { get }
}
