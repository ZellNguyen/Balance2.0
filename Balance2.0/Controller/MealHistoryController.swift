//
//  MealHistoryController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-11.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class MealHistoryController: UITableViewController {
    
    var mealPostsList: PostsList! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMealPost()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealPostsList.allPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealHistoryCell
        let mealPost = mealPostsList.allPosts[indexPath.row] as! MealPost
        
        cell.dateLabel.text = DateFormatter.localizedString(from: mealPost.date as Date, dateStyle: .short, timeStyle: .short)
        cell.mealTypeLabel.text = mealPost.type.rawValue
        cell.captionLabel.text = mealPost.caption
        cell.mealImage.image = mealPost.image
        
        return cell
    }
    
    func loadMealPost() {
        let posts = PostsList()
        posts.loadData()
        
        // Initialize meal post list
        mealPostsList = PostsList()
        
        // Filter meal posts
        for post in posts.allPosts{
            if let mealPost = post as? MealPost{
                if mealPost.user == ProfileManager.myProfile.myself {
                    mealPostsList.add(mealPost)
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMealPost()
        tableView.reloadData()
    }
}
