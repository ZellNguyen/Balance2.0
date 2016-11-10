//
//  NewsFeedController.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class NewsFeedController: UITableViewController {
    
    var postsList: PostsList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsList = PostsList()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        //tableView.estimatedRowHeight = 46.0
        //tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (postsList.allPosts.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let post = postsList.allPosts[indexPath.row] as? MealPost {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealPostCell
            
            cell.userLabel.text = post.user.firstName
            
            let dateFormatter = DateFormatter.localizedString(from: post.date as Date, dateStyle: .short, timeStyle: .short)
            cell.dateLabel.text = dateFormatter
            cell.mealTypeLabel.text = post.type.rawValue
            cell.commentButton.tag = indexPath.row
            
            // Set up dynamic image view's size
            if let image = post.image {
                let aspectRatio = image.size.height / image.size.width
                let heightConstraint = NSLayoutConstraint(item: cell.postImage, attribute: .height, relatedBy: .equal, toItem: cell.postImage, attribute: .width, multiplier: aspectRatio, constant: 1)
                cell.addConstraint(heightConstraint)
                cell.postImage.image = image
            }
            else {
                cell.postImage.image = nil
            }
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowComments" {
            print("SEND")
            let commentsViewController = segue.destination as! CommentViewController
            
            if let selectedCommentButton = sender as? UIButton {
                print("HANOI")
                let selectedPost = postsList.allPosts[selectedCommentButton.tag]
                commentsViewController.commentsList = selectedPost.comments
            }
        }
    }
    
}
