//
//  CommentsViewController.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-09.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class CommentTableViewController: UITableViewController {
    var commentsList: CommentsList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 46.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.allComments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        
        let comment = commentsList.allComments[indexPath.row]
        
        cell.userLabel.text = comment.user.fullName
        cell.bodyLabel.text = comment.content
        let dateFormatter = DateFormatter.localizedString(from: comment.datePosted as Date, dateStyle: .short, timeStyle: .short)
        cell.dateLabel.text = dateFormatter
        
        return cell
    }
}
