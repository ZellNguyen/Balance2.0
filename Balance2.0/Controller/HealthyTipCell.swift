//
//  HealthyTipCell.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-10.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class HealthyTipCell: UITableViewCell {
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var parentView: UIView!

    @IBOutlet var commentButton: UIButton!
    @IBOutlet var numberOfLikes: UILabel!
    @IBOutlet var numberOfComments: UILabel!
}
