//
//  NewsFeedController.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-08.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class NewsFeedController: UITableViewController {
    
    var postsList: PostsList? = PostsList()
    
    var reminder: Challenge? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if isLoggedIn {
            postsList = PostsList.main
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400.0
        
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (postsList!.allPosts.count + 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // In case Reminder
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell") as! ReminderCell
            
            
            
            if let mealChallenge = reminder as? IndividualMealChallenge {
                cell.challengeImage.image = UIImage.init(named: "Challenge(N)-1")
                if mealChallenge.sender != ProfileManager.myProfile.myself {
                    cell.titleLabel.text = "Today is \"\(mealChallenge.option.name!)\" with \(mealChallenge.sender.fullName!)"
                }
                else {
                   cell.titleLabel.text = "Today is \"\(mealChallenge.option.name!)\" with \(mealChallenge.receiver?.fullName!)"
                }
            }
            
            if let exerciseChallenge = reminder as? IndividualExerciseChallenge {
                cell.challengeImage.image = UIImage.init(named: "Challenge(E)-1")
                if exerciseChallenge.sender != ProfileManager.myProfile.myself {
                    cell.titleLabel.text = "Today is a step challenge with \(exerciseChallenge.sender.fullName!)"
                }
                else {
                    cell.titleLabel.text = "Today is a step challenge with \(exerciseChallenge.receiver?.fullName!)"
                }
            }
            
            cell.parentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            cell.parentView.layer.shadowColor = UIColor.black.cgColor
            cell.parentView.layer.shadowOpacity = 0.3
            cell.parentView.layer.shadowOffset = CGSize(width: 0, height: 4)
            //cell.parentView.layer.shadowPath = UIBezierPath(rect: CGRect(x: cell.parentView.bounds.minX, y: cell.parentView.bounds.minY, width: cell.parentView.bounds.width, height: cell.parentView.bounds.height + 4)).cgPath
            cell.parentView.layer.shadowRadius = 3
            cell.parentView.layer.shouldRasterize = true
            cell.parentView.layer.rasterizationScale = UIScreen.main.scale
            
            return cell
        }
        
        // In case Dequeue Meal Cells
        if let post = postsList?.allPosts[indexPath.row-1] as? MealPost {
            
            // Dequeue Meal Cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealPostCell
            
            // Set up user label
            cell.userLabel.text = post.user.fullName
            
            // Set up user image
            cell.userImage.image = post.user.profile.picture
            cell.userImage.layer.masksToBounds = true
            cell.userImage.layer.cornerRadius = CGFloat(21.5)
            
            // Set up caption label
            cell.captionLabel.text = post.caption
            
            // Set up comment butotn
            cell.commentButton.tag = indexPath.row-1
            cell.commentButton.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
            cell.numberOfComments.text = String(post.comments.allComments.count)
            
            // Set up like button 
            cell.likeButton.tag = indexPath.row-1
            cell.likeButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            cell.numberOfLikes.text = String(post.likes.count)
            
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
            cell.parentView.layer.shadowOffset = CGSize(width: 0, height: 4)
            //cell.parentView.layer.shadowPath = UIBezierPath(rect: CGRect(x: cell.parentView.bounds.minX, y: cell.parentView.bounds.minY, width: cell.parentView.bounds.width, height: cell.parentView.bounds.height + 4)).cgPath
            cell.parentView.layer.shadowRadius = 3
            cell.parentView.layer.shouldRasterize = true
            cell.parentView.layer.rasterizationScale = UIScreen.main.scale
            
            cell.selectionStyle = .none
            return cell
        }
            
        // In case Dequeue Charity Cell
        else if let post = postsList?.allPosts[indexPath.row-1] as? CharityPost {
            
            // Dequeue exercise cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharityCell", for: indexPath) as! CharityCell
            
            // set up user label
            cell.userLabel.text = post.user.fullName
            cell.userImage.image = post.user.profile.picture
            cell.userImage.layer.cornerRadius = CGFloat(21.5)
            cell.userImage.layer.masksToBounds = true
            
            // Set up caption
            if let caption = post.caption {
                cell.captionLabel.text = caption
            }

            // Set up buttons
            cell.commentButton.tag = indexPath.row-1
            cell.commentButton.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
            cell.numberOfComments.text = String(post.comments.allComments.count)
            
            cell.likeButton.tag = indexPath.row-1
            cell.likeButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            cell.numberOfLikes.text = String(post.likes.count)
            
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
            //cell.parentView.layer.shadowOffset = CGSize(width: 0, height: 4)
            cell.parentView.layer.shadowPath = UIBezierPath(rect: CGRect(x: cell.parentView.bounds.minX, y: cell.parentView.bounds.minY, width: cell.parentView.bounds.width, height: cell.parentView.bounds.height + 4)).cgPath
            cell.parentView.layer.shadowRadius = 3
            cell.parentView.layer.shouldRasterize = true
            cell.parentView.layer.rasterizationScale = UIScreen.main.scale
            
            cell.selectionStyle = .none
            return cell
        }
            
        // In case Dequeue Healthy Tip Post
        else if let post = postsList?.allPosts[indexPath.row-1] as? HealthyTipPost {
            
            // Dequeue healthy tip cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "HealthyTipCell", for: indexPath) as!HealthyTipCell
            
            // Set up caption
            cell.captionLabel.text = post.title
            
            // Set up buttons
            cell.commentButton.tag = indexPath.row-1
            cell.commentButton.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
            cell.numberOfComments.text = String(post.comments.allComments.count)
            
            cell.likeButton.tag = indexPath.row-1
            cell.likeButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            cell.numberOfLikes.text = String(post.likes.count)

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
            cell.parentView.layer.shadowOffset = CGSize(width: 0, height: 4)
            //cell.parentView.layer.shadowPath = UIBezierPath(rect: CGRect(x: cell.parentView.bounds.minX, y: cell.parentView.bounds.minY, width: cell.parentView.bounds.width, height: cell.parentView.bounds.height + 4)).cgPath
            cell.parentView.layer.shadowRadius = 3
            cell.parentView.layer.shouldRasterize = true
            cell.parentView.layer.rasterizationScale = UIScreen.main.scale
            
            cell.selectionStyle = .none
            return cell
            
        }
            
        else if let post = postsList?.allPosts[indexPath.row-1] as? MealChallengePost {
            
            //Dequeue challenge cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealChallengeCell", for: indexPath) as! MealChallengeCell
            
            cell.user1Image.image = post.mealChallenge[0].sender.profile.picture
            cell.user1Image.layer.masksToBounds = true
            cell.user1Image.layer.cornerRadius = CGFloat(21.5)
            cell.user1Label.text = post.mealChallenge[0].sender.fullName
            
            cell.user2Image.image = post.mealChallenge[0].receiver?.profile.picture
            cell.user2Image.layer.masksToBounds = true
            cell.user2Image.layer.cornerRadius = CGFloat(21.5)
            cell.user2Label.text = post.mealChallenge[0].receiver?.fullName
            
            cell.captionLabel.text = post.caption
            cell.image1.image = post.mealChallenge[0].post?.image
            cell.image2.image = post.mealChallenge[1].post?.image
            
            cell.like1Button.tag = indexPath.row-1
            cell.like1Button.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            cell.like2Button.tag = indexPath.row
            cell.like2Button.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            
            cell.commentButton.tag = indexPath.row-1
            cell.commentButton.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
            cell.numberOfComments.text = String(post.comments.allComments.count)
            
            cell.parentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            cell.parentView.layer.shadowColor = UIColor.black.cgColor
            cell.parentView.layer.shadowOpacity = 0.3
            cell.parentView.layer.shadowOffset = CGSize(width: 0, height: 4)
            //cell.parentView.layer.shadowPath = UIBezierPath(rect: CGRect(x: cell.parentView.bounds.minX, y: cell.parentView.bounds.minY, width: cell.parentView.bounds.width, height: cell.parentView.bounds.height + 4)).cgPath
            cell.parentView.layer.shadowRadius = 3
            cell.parentView.layer.shouldRasterize = true
            cell.parentView.layer.rasterizationScale = UIScreen.main.scale
            
            cell.selectionStyle = .none
            return cell
        }
         
        // In other cases
        else {
            return UITableViewCell()
        }
    }

    
    func like(_ sender: UIButton){
        // Change button image
        if let post = postsList?.allPosts[sender.tag] as? HealthyTipPost {
            if let _ = post.likes.index(of: ProfileManager.myProfile.myself) {
                sender.setImage(UIImage.init(named: "unlike_Health"), for: .normal)
                self.postsList?.unlike(atPost: sender.tag)
                //self.tableView.reloadData()
                let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! HealthyTipCell
                cell.numberOfLikes.text = String(post.likes.count)
            }
            else {
                self.postsList?.like(atPost: sender.tag)
                sender.setImage(UIImage.init(named: "liked_Health"), for: .normal)
                //self.tableView.reloadData()
                let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! HealthyTipCell
                cell.numberOfLikes.text = String(post.likes.count)
            }
            return
        }
        
        if let post = postsList?.allPosts[sender.tag] as? CharityPost {
            if let _ = post.likes.index(of: ProfileManager.myProfile.myself) {
                sender.setImage(UIImage.init(named: "unlike_Charity"), for: .normal)
                self.postsList?.unlike(atPost: sender.tag)
                //self.tableView.reloadData()
                let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! CharityCell
                cell.numberOfLikes.text = String(post.likes.count)
            }
            else {
                self.postsList?.like(atPost: sender.tag)
                sender.setImage(UIImage.init(named: "liked_Charity"), for: .normal)
                //self.tableView.reloadData()
                let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! CharityCell
                cell.numberOfLikes.text = String(post.likes.count)
            }
            
            //print(post.likes.count)
            return
        }
        
        if let post = postsList?.allPosts[sender.tag] as? MealPost {
            if let _ = post.likes.index(of: ProfileManager.myProfile.myself) {
                self.postsList?.unlike(atPost: sender.tag)
                sender.setImage(UIImage.init(named: "unlike_Food"), for: .normal)
                //self.tableView.reloadData()
                let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! MealPostCell
                cell.numberOfLikes.text = String(post.likes.count)
            }
            else {
                self.postsList?.like(atPost: sender.tag)
                sender.setImage(UIImage.init(named: "liked_Food"), for: .normal)
                //self.tableView.reloadData()
                let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! MealPostCell
                cell.numberOfLikes.text = String(post.likes.count)
            }
            return
        }

        if let _ = postsList?.allPosts[sender.tag] as? MealChallengePost {
            sender.isSelected = !sender.isSelected
            
            if sender.isSelected{
                sender.setImage(UIImage.init(named: "liked_Food"), for: .normal)
            }
            else {
                sender.setImage(UIImage.init(named: "unliked_Food"), for: .normal)
            }
        }
    }
    
    func comment(_ sender: UIButton){
        let commentView = self.storyboard?.instantiateViewController(withIdentifier: "CommentTableViewController") as! CommentTableViewController
        commentView.commentsList = self.postsList?.allPosts[sender.tag].comments
        self.navigationController?.pushViewController(commentView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let mealReminder = reminder as? IndividualMealChallenge {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                vc.link = mealReminder.link!
                vc.challenge = mealReminder
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else {
            if let post = PostsList.main.allPosts[indexPath.row-1] as? HealthyTipPost {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                vc.link = post.link
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.postsList = PostsList.main
        
        // Load reminder
        let mealChallenges = ChallengeList.mealChallengeList
        let exerciseChallenges = ChallengeList.exerciseChallengeList
        
        let mainChallenges = ChallengeList()
        mainChallenges.allChallenges = mealChallenges.allChallenges
        mainChallenges.allChallenges.append(contentsOf: exerciseChallenges.allChallenges)
        mainChallenges.allChallenges.sort(by: {
            $0.toDate < $1.toDate
        })
        
        reminder = mainChallenges.allChallenges[0]
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.postsList = nil
        self.reminder = nil
    }
}
