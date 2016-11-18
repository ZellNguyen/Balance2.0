//
//  CommentViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-10.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var commentTableView: UIView!
    @IBOutlet var commentTextField: UITextField!
    
    var commentsList: CommentsList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        commentTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentTextField.resignFirstResponder()
        return true
    }
    
    func reloadData(){
        let commentTableController = self.childViewControllers[0] as! CommentTableViewController
        commentTableController.commentsList = self.commentsList
        commentTableController.tableView.reloadData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let comment = commentTextField.text {
            commentsList.add(comment: comment)
            reloadData()
            commentTextField.text = ""
        }
    }
    
    
}
