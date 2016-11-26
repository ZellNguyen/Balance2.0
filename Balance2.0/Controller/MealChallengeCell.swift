//
//  MealChallengeCell.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-26.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class MealChallengeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var user1Image: UIImageView!
    @IBOutlet var user1Label: UILabel!

    @IBOutlet var user2Image: UIImageView!
    @IBOutlet var user2Label: UILabel!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var like1Button: UIButton!
    @IBOutlet var like2Button: UIButton!
    @IBOutlet var commentButton: UIButton!
}
