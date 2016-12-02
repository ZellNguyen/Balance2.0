//
//  ReminderCell.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-12-01.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = .none
    }
    
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var challengeImage: UIImageView!

}
