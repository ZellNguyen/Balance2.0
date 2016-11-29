//
//  RankingViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-25.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    @IBOutlet var rankingTableView: UITableView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userPositionLabel: UILabel!
    @IBOutlet var userStepLabel: UILabel!

    @IBOutlet var dailyButton: UIButton!
    @IBOutlet var weeklyButton: UIButton!
    @IBOutlet var monthlyButton: UIButton!
    var friendList: [UserAccount]? = ProfileManager.myProfile.friendList.allFriends
    var filterfriendList: [UserAccount]? = [UserAccount]()
    
    var isSearchActive = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        //searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        self.rankingTableView.tableHeaderView = searchController.searchBar

        self.profileImage.image = ProfileManager.myProfile.profile.picture
        
        self.friendList?.append(ProfileManager.myProfile.myself)
        self.friendList?.sort(by: {
            return $0.profile.dailySteps > $1.profile.dailySteps
        })
        
        // User Info
        self.userPositionLabel.text = String((self.friendList?.index(of: ProfileManager.myProfile.myself)!)! + 1)
        self.userStepLabel.text = String(ProfileManager.myProfile.profile.dailySteps)
        
        //Button Style
        self.dailyButton.layer.cornerRadius = 9
        self.dailyButton.layer.masksToBounds = true
        self.weeklyButton.layer.cornerRadius = 9
        self.weeklyButton.layer.masksToBounds = true
        self.monthlyButton.layer.cornerRadius = 9
        self.monthlyButton.layer.masksToBounds = true
        
        self.rankingTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filterfriendList!.count : friendList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = isSearchActive ? filterfriendList?[indexPath.row] : friendList?[indexPath.row]
        let cell = self.rankingTableView.dequeueReusableCell(withIdentifier: "FriendRankingCell", for: indexPath) as! FriendRankingCell
        
        cell.friendLabel.text = friend?.fullName
        cell.stepLabel.text = String(friend!.profile.dailySteps)
        cell.challengButton.tag = indexPath.row
        cell.challengButton.addTarget(self, action: #selector(challenge(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func challenge(_ sender: UIButton){
        performSegue(withIdentifier: "ShowChallengeFromRanking", sender: sender)
        self.searchController.isActive = false;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewExerciseChallengeViewController {
            if let sender = sender as? UIButton {
                if !isSearchActive {
                    vc.receiver = friendList?[sender.tag]
                }
                else {
                    vc.receiver = filterfriendList?[sender.tag]
                }
            }
        }
    }
    
    // MARK: SEARCH
    func searchFriend(by string: String) {
        self.filterfriendList = self.friendList?.filter({ (friend: UserAccount) in
            let isNameContained = friend.fullName.range(of: string)
            let isEmailContained = friend.email.range(of: string)
            return (isNameContained != nil) || (isEmailContained != nil)
        })
    }
    func updateSearchResults(for searchController: UISearchController) {
        self.isSearchActive = true
        self.searchFriend(by: searchController.searchBar.text!)
        self.rankingTableView.reloadData()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.isSearchActive = false
        self.rankingTableView.reloadData()
    }
    
    /*func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearchActive = false
        self.rankingTableView.reloadData()
        print(isSearchActive)
    }*/
    
    override func viewWillDisappear(_ animated: Bool) {
        self.friendList = nil
        self.filterfriendList = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.friendList = ProfileManager.myProfile.friendList.allFriends
        self.filterfriendList = [UserAccount]()
    }

}

class FriendRankingCell: UITableViewCell {
    @IBOutlet var friendLabel: UILabel!
    @IBOutlet var stepLabel: UILabel!
    @IBOutlet var challengButton: UIButton!
    
}
