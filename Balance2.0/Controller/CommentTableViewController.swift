//
//  CommentsViewController.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-09.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class CommentTableViewController: UITableViewController, UITextFieldDelegate {
    var commentsList: CommentsList?
    
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    override func viewDidLoad() {
        print(commentsList?.allComments.count)
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 46.0
        self.title = "Comments"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList!.allComments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        
        let comment = commentsList?.allComments[indexPath.row]
        
        cell.userLabel.text = comment?.user.fullName
        cell.bodyLabel.text = comment?.content
        cell.userImage.image = comment?.user.profile.picture
        cell.userImage.layer.masksToBounds = true
        cell.userImage.layer.cornerRadius = CGFloat(21.5)
        
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let comment = commentTextField.text
        if !(comment?.isEmpty)!{
            self.commentsList?.add(comment: comment!)
        }
        
        self.commentTextField.resignFirstResponder()
        self.commentTextField.text = nil
        self.tableView.reloadData()
        return true
    }
    
    @IBAction func send(_ sender: UIButton) {
        let comment = commentTextField.text
        if !(comment?.isEmpty)!{
            self.commentsList?.add(comment: comment!)
        }
        
        self.commentTextField.resignFirstResponder()
        self.commentTextField.text = nil
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        commentsList = nil
    }
    
    
    
}
