//
//  CommentsList.swift
//  Balance
//
//  Created by Hoa Nguyen on 2016-11-09.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class CommentsList {
    var allComments = [Comment]()
    
    func add(comment content: String){
        let comment = Comment(withContent: content)
        allComments.append(comment)
    }
    
    func add(comment: Comment){
        allComments.append(comment)
    }
    
    init(){
    }
}
