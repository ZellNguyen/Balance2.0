//
//  PresentCharityViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class PresentCharityTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate{
    var charityList: CharityList!
    var filteredCharity = [Charity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charityList = CharityList.main
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charityList.launchedCharites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PresentCharityCell", for: indexPath) as! PresentCharityCell
        
        let launchedCharity = charityList.launchedCharites[indexPath.row]
        
        // Set up Cell
        cell.titleLabel.text = launchedCharity.title
        cell.seeMoreButton.tag = indexPath.row
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
        singleCharityViewController.company = charity.company
        singleCharityViewController.caption = charity.caption
        singleCharityViewController.image = charity.image
        singleCharityViewController.charityTitle = charity.title
        
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
}

class SingleCharityViewController: UIViewController {
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var charityImage: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var donateButton: UIButton!
    
    var company: String!
    var image: UIImage!
    var caption: String!
    var charityTitle: String!
    var tag: Int! = 0
    
    var isDonated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyLabel.text = company
        charityImage.image = image
        captionLabel.text = caption
        
        // Rounded Button 
        donateButton.layer.cornerRadius = 20
        donateButton.layer.shadowColor = UIColor.black.cgColor
        donateButton.layer.shadowOpacity = 0.3
        donateButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        donateButton.layer.shadowRadius = 4
        
        // Hide share Button
        shareButton.isHidden = true
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
            self.isDonated = true
            self.shareButton.isHidden = false
            self.changeCaptionAfterDonated(donatedSteps!)
            //self.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        confirmBox.addAction(cancelAction)
        confirmBox.addAction(okAction)
        
        present(confirmBox, animated: true, completion: nil)
    }
    
    // Change Caption After Donate
    func changeCaptionAfterDonated(_ amount: Int) {
        let money = Float(amount) / 10000
        let moneyInString = String(format: "%.2f", money)
        let caption = "\(self.company!) donated \(moneyInString) for \(self.charityTitle!) project. \n\n Thank you for your donation!"
        
        self.captionLabel.text = caption
        self.donateButton.isHidden = true
    }
    
    @IBOutlet var shareButton: UIButton!
    
    @IBAction func share(_ sender: UIButton){
        
        if !isDonated {
            return
        }
        let charity = CharityList.main.launchedCharites[self.tag]
        let post = CharityPost(charity: charity)
        
        PostsList.main.add(post)
        
        dismiss(animated: true, completion: nil)
    }
}

