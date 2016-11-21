//
//  NewsFeedController.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class NewsFeedController: UITableViewController {
    
    var postsList: PostsList! = PostsList.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (postsList.allPosts.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // In case Dequeue Meal Cells
        if let post = postsList.allPosts[indexPath.row] as? MealPost {
            
            // Dequeue Meal Cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell") as! MealPostCell
            
            // Set up user label
            cell.userLabel.text = post.user.fullName
            
            
            // Set up date label
            let dateFormatter = DateFormatter.localizedString(from: post.date as Date, dateStyle: .short, timeStyle: .short)
            cell.dateLabel.text = dateFormatter
            
            // Set up meal type label
            cell.mealTypeLabel.text = post.type.rawValue
            
            // Set up comment butotn
            cell.commentButton.tag = indexPath.row
            let numberOfComments = post.comments.allComments.count
            cell.commentButton.setTitle("Comments (\(numberOfComments))", for: .normal)
            
            // Set up dynamic image view's size
            if let image = post.image {
                let aspectRatio = image.size.height / image.size.width
                let heightConstraint = NSLayoutConstraint(item: cell.postImage, attribute: .height, relatedBy: .equal, toItem: cell.postImage, attribute: .width, multiplier: aspectRatio, constant: 1)
                cell.postImage.addConstraint(heightConstraint)
                cell.layoutIfNeeded()
                tableView.layoutIfNeeded()
                cell.postImage.image = image
            }
            else {
                cell.postImage.image = nil
            }
            return cell
        }
            
        // In case Dequeue Exercise Cell
        else if let post = postsList.allPosts[indexPath.row] as? ExercisePost {
            
            // Dequeue exercise cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
            
            // set up user label
            cell.userLabel.text = post.user.fullName
            
            // Set up date label
            let dateFormatter = DateFormatter.localizedString(from: post.date as Date, dateStyle: .short, timeStyle: .short)
            cell.dateLabel.text = dateFormatter
            
            // Set up caption
            if let caption = post.caption {
                cell.captionLabel.text = caption
            }

            // Set up comment button
            cell.commentButton.tag = indexPath.row
            let numberOfComments = post.comments.allComments.count
            cell.commentButton.setTitle("Comments (\(numberOfComments))", for: .normal)
            
            // Set up steps label
            cell.stepLabel.text = String(post.steps)
            
            // Set up dynamic image view's size
            if let image = post.image {
                let aspectRatio = image.size.height / image.size.width
                let heightConstraint = NSLayoutConstraint(item: cell.postImage, attribute: .height, relatedBy: .equal, toItem: cell.postImage, attribute: .width, multiplier: aspectRatio, constant: 1)
                cell.postImage.addConstraint(heightConstraint)
                
                cell.postImage.image = image
            }
            else {
                cell.postImage.image = nil
            }
            
            return cell
        }
            
        // In case Dequeue Healthy Tip Post
        else if let post = postsList.allPosts[indexPath.row] as? HealthyTipPost {
            
            // Dequeue healthy tip cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "HealthyTipCell", for: indexPath) as!HealthyTipCell
            
            // set up user label
            cell.titleLabel.text = post.title
            
            // Set up date label
            let dateFormatter = DateFormatter.localizedString(from: post.date as Date, dateStyle: .short, timeStyle: .short)
            cell.dateLabel.text = dateFormatter
            
            // Set up caption
            if let caption = post.caption {
                cell.captionLabel.text = caption
            }
            
            // Set up comment button
            cell.commentButton.tag = indexPath.row
            let numberOfComments = post.comments.allComments.count
            cell.commentButton.setTitle("Comments (\(numberOfComments))", for: .normal)
            
            // Set up dynamic image view's size
            if let image = post.image {
                let aspectRatio = image.size.height / image.size.width
                let heightConstraint = NSLayoutConstraint(item: cell.postImage, attribute: .height, relatedBy: .equal, toItem: cell.postImage, attribute: .width, multiplier: aspectRatio, constant: 0)
                cell.postImage.addConstraint(heightConstraint)
                cell.layoutIfNeeded()
                cell.postImage.image = image
            }
            else {
                cell.postImage.image = nil
            }
            
            return cell
            
        }
         
        // In other cases
        else {
            return UITableViewCell()
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
    */
    
}
