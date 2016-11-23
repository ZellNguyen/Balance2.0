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
        
        tableView.separatorStyle = .none
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
            
            // Set up user image
            cell.userImage.image = UIImage.init(named: "default-image-post")
            cell.userImage.layer.masksToBounds = true
            cell.layer.cornerRadius = 9
            
            // Set up caption label
            cell.captionLabel.text = post.caption
            
            // Set up comment butotn
            cell.commentButton.tag = indexPath.row
            
            // Set up like button 
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            
            // Set up meal tags
            if post.tags.foodTags.count > 0 {
                for view in cell.tagsStackView.subviews {
                    view.removeFromSuperview()
                }
                
                for tag in post.tags.foodTags {
                    let label = UILabel()
                    label.text = ("   \(tag.name!)   ")
                    label.layer.backgroundColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1).cgColor
                    label.layer.cornerRadius = 9
                    label.adjustsFontSizeToFitWidth = true
                    label.textColor = UIColor.white
                    label.font = UIFont.preferredFont(forTextStyle: .caption1)
                    
                    cell.tagsStackView.addArrangedSubview(label)
                }
            }
                
            else {
                cell.tagsStackView.isHidden = true
            }
            
            // Set up dynamic image view's size
            /*if let image = post.image {
                let aspectRatio = image.size.height / image.size.width
                let heightConstraint = NSLayoutConstraint(item: cell.postImage, attribute: .height, relatedBy: .equal, toItem: cell.postImage, attribute: .width, multiplier: aspectRatio, constant: 1)
                cell.postImage.addConstraint(heightConstraint)
                cell.layoutIfNeeded()
                tableView.layoutIfNeeded()
                cell.postImage.image = image
            }
            else {
                cell.postImage.image = nil
            }*/
            
            cell.postImage.image = post.image
            
            cell.parentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            cell.parentView.layer.shadowColor = UIColor.black.cgColor
            cell.parentView.layer.shadowOpacity = 0.3
            cell.parentView.layer.shadowOffset = CGSize(width: -2, height: 5)
            cell.parentView.layer.shadowRadius = 2
            
            return cell
        }
            
        // In case Dequeue Charity Cell
        else if let post = postsList.allPosts[indexPath.row] as? CharityPost {
            
            // Dequeue exercise cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharityCell", for: indexPath) as! CharityCell
            
            // set up user label
            cell.userLabel.text = post.user.fullName
            
            // Set up caption
            if let caption = post.caption {
                cell.captionLabel.text = caption
            }

            // Set up buttons
            cell.commentButton.tag = indexPath.row
            
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            
            // Set up dynamic image view's size
            /*if let image = post.image {
                let aspectRatio = image.size.height / image.size.width
                let heightConstraint = NSLayoutConstraint(item: cell.postImage, attribute: .height, relatedBy: .equal, toItem: cell.postImage, attribute: .width, multiplier: aspectRatio, constant: 1)
                cell.postImage.addConstraint(heightConstraint)
                
                cell.postImage.image = image
            }
            else {
                cell.postImage.image = nil
            }*/
            
            cell.postImage.image = post.image
            
            cell.parentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            cell.parentView.layer.shadowColor = UIColor.black.cgColor
            cell.parentView.layer.shadowOpacity = 0.3
            cell.parentView.layer.shadowOffset = CGSize(width: -2, height: 5)
            cell.parentView.layer.shadowRadius = 2
            
            return cell
        }
            
        // In case Dequeue Healthy Tip Post
        else if let post = postsList.allPosts[indexPath.row] as? HealthyTipPost {
            
            // Dequeue healthy tip cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "HealthyTipCell", for: indexPath) as!HealthyTipCell
            
            // Set up caption
            if let caption = post.caption {
                cell.captionLabel.text = caption
            }
            
            // Set up buttons
            cell.commentButton.tag = indexPath.row
            
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)

            // Set up dynamic image view's size
            /*if let image = post.image {
                let aspectRatio = image.size.height / image.size.width
                let heightConstraint = NSLayoutConstraint(item: cell.postImage, attribute: .height, relatedBy: .equal, toItem: cell.postImage, attribute: .width, multiplier: aspectRatio, constant: 0)
                cell.postImage.addConstraint(heightConstraint)
                cell.layoutIfNeeded()
                cell.postImage.image = image
            }
            else {
                cell.postImage.image = nil
            }*/
            
            cell.postImage.image = post.image
            
            cell.parentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            cell.parentView.layer.shadowColor = UIColor.black.cgColor
            cell.parentView.layer.shadowOpacity = 0.3
            cell.parentView.layer.shadowOffset = CGSize(width: -2, height: 5)
            cell.parentView.layer.shadowRadius = 2
            
            return cell
            
        }
         
        // In other cases
        else {
            return UITableViewCell()
        }
    }

    
    func like(_ sender: UIButton){
        // Change button image
        if let post = postsList.allPosts[sender.tag] as? HealthyTipPost {
            if let _ = post.likes.index(of: ProfileManager.myProfile.myself) {
                sender.setImage(UIImage.init(named: "unlike_Health"), for: .normal)
                self.postsList.unlike(atPost: sender.tag)
            }
            else {
                self.postsList.like(atPost: sender.tag)
                sender.setImage(UIImage.init(named: "liked_Health"), for: .normal)
            }
            return
        }
        
        if let post = postsList.allPosts[sender.tag] as? CharityPost {
            if let _ = post.likes.index(of: ProfileManager.myProfile.myself) {
                sender.setImage(UIImage.init(named: "unlike_Charity"), for: .normal)
                self.postsList.unlike(atPost: sender.tag)
            }
            else {
                self.postsList.like(atPost: sender.tag)
                sender.setImage(UIImage.init(named: "liked_Charity"), for: .normal)
            }
            print(post.likes.count)
            return
        }
        
        if let post = postsList.allPosts[sender.tag] as? MealPost {
            if let _ = post.likes.index(of: ProfileManager.myProfile.myself) {
                self.postsList.unlike(atPost: sender.tag)
                sender.setImage(UIImage.init(named: "unlike_Food"), for: .normal)
            }
            else {
                self.postsList.like(atPost: sender.tag)
                sender.setImage(UIImage.init(named: "liked_Food"), for: .normal)
            }
            return
        }
    }
    
}
