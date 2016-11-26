//
//  Post.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

protocol Post {
    var caption: String? { get set }
    var date: Date! { get set }
    var comments: CommentsList! { get set }
}
