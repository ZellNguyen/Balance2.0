//
//  PresentCharityViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class PresentCharityTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    var charityList: CharityList!
    var filteredCharity = [Charity]()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charityList = CharityList.main
        
        searchController.isActive = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        //definesPresentationContext = true
        searchController.searchBar.placeholder = "Search charity"
        tableView.tableHeaderView = searchController.searchBar

        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return self.filteredCharity.count
        }
        return self.charityList.launchedCharites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PresentCharityCell", for: indexPath) as! PresentCharityCell
        
        let launchedCharity = searchActive ? self.filteredCharity[indexPath.row] : charityList.launchedCharites[indexPath.row]
        
        // Set up Cell
        cell.companyLabel.text = launchedCharity.company
        cell.titleLabel.text = launchedCharity.title
        cell.seeMoreButton.tag = indexPath.row
        cell.progressView.progress = Float(launchedCharity.currentSteps / launchedCharity.goalSteps * 100)
        cell.seeMoreButton.addTarget(self, action: #selector(seeMore(_:)), for: .touchUpInside)
        
        return cell
    }

    // See PopUp after touching See more button
    func seeMore(_ sender: UIButton) {
        let charity = charityList.launchedCharites[sender.tag]
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let singleCharityViewController: SingleCharityViewController = storyboard.instantiateViewController(withIdentifier: "SingleCharityViewController") as! SingleCharityViewController
        
        singleCharityViewController.modalPresentationStyle = .popover
        singleCharityViewController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
        singleCharityViewController.charityTitle = charity.title
        singleCharityViewController.company = charity.company
        singleCharityViewController.caption = charity.caption
        singleCharityViewController.image = charity.image
        singleCharityViewController.goalSteps = charity.goalSteps
        
        // Pass index to pop over view
        singleCharityViewController.tag = sender.tag
        
        let popOverViewController = singleCharityViewController.popoverPresentationController
        popOverViewController?.permittedArrowDirections = .any
        popOverViewController?.delegate = self
        popOverViewController?.sourceView = sender
        popOverViewController?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
        present(singleCharityViewController, animated: true, completion: nil)
    }
    
    // Reload Data 
    override func viewWillAppear(_ animated: Bool) {
        charityList.update()
        tableView.reloadData()
    }
    
    func searchCharity(byString string: String!) {
        self.filteredCharity = self.charityList.launchedCharites.filter({(charity: Charity) in
            let title = charity.title.range(of: string)
            let company = charity.company.range(of: string)
            
            return ((title != nil) || (company != nil))
        })
        tableView.reloadData()
    }
    
    @IBOutlet var charitySearchBar: UISearchBar!
    var searchActive: Bool = false
    
    // MARK: Search
    func updateSearchResults(for searchController: UISearchController) {
        self.searchActive = true
        searchCharity(byString: searchController.searchBar.text!)
    }
    
}

class SingleCharityViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var charityImage: UIImageView!
    @IBOutlet var goalStepsLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    
    var charityTitle: String!
    var company: String!
    var image: UIImage!
    var goalSteps: Int!
    var caption: String!
    var tag: Int! = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = charityTitle
        companyLabel.text = company
        charityImage.image = image
        goalStepsLabel.text = String(goalSteps)
        captionLabel.text = caption
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func donate(_ sender: UIButton) {
        if ProfileManager.myProfile.profile.currentSteps == 0 {
            let alertBox = UIAlertController(title: "Donation failed", message: "Sorry you don't have any step to donate", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertBox.addAction(okAction)
            
            present(alertBox, animated: true, completion: nil)
            return
        }
        let confirmBox = UIAlertController(title: "Confirm Registration", message: "Are you sure that you will take part in this charity?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            let charity = CharityList.main.launchedCharites[self.tag]
            let donatedSteps = ProfileManager.myProfile.profile.currentSteps
            ProfileManager.myProfile.profile.donate(steps: donatedSteps!, for: charity)
            CharityList.main.update()
            self.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        confirmBox.addAction(cancelAction)
        confirmBox.addAction(okAction)
        
        present(confirmBox, animated: true, completion: nil)
    }
}

