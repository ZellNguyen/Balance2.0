//
//  MealHistoryController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-11.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class MealHistoryController: UITableViewController {
    
    var mealPostsList: PostsList? = PostsList.meals
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealPostsList!.allPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealHistoryCell
        let mealPost = mealPostsList?.allPosts[indexPath.row] as! MealPost
        
        cell.dateLabel.text = DateFormatter.localizedString(from: mealPost.date as Date, dateStyle: .medium, timeStyle: .none)
        
        cell.mealImage.image = mealPost.image
        
        if mealPost.tags.foodTags.count > 0 {
            for view in cell.tagStackView.subviews {
                view.removeFromSuperview()
            }
            
            for tag in mealPost.tags.foodTags {
                let label = UILabel()
                label.text = ("   \(tag.name!)   ")
                label.layer.backgroundColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1).cgColor
                label.layer.cornerRadius = 9
                label.adjustsFontSizeToFitWidth = true
                label.textColor = UIColor.white
                label.font = UIFont.preferredFont(forTextStyle: .caption1)
                
                cell.tagStackView.addArrangedSubview(label)
            }
        }
        
        else {
            cell.tagStackView.isHidden = true
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mealPostsList = PostsList.meals
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mealPostsList = nil
    }
}
