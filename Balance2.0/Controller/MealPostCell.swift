//
//  NewsFeedCell.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-09.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class MealPostCell: UITableViewCell {
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var parentView: UIView!
    
    @IBOutlet var numberOfLikes: UILabel!
    @IBOutlet var numberOfComments: UILabel!
    @IBOutlet var tagsStackView: UIStackView!
}
