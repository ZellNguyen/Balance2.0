//
//  PresentCharityViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class PresentCharityTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate{
    var charityList: CharityList?
    //var filteredCharity: [Charity]? = [Charity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charityList = CharityList.main
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charityList!.launchedCharites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PresentCharityCell", for: indexPath) as! PresentCharityCell
        
        let launchedCharity = charityList?.launchedCharites[indexPath.row]
        
        // Set up Cell
        cell.titleLabel.text = launchedCharity?.title
        cell.seeMoreButton.tag = indexPath.row
        cell.seeMoreButton.addTarget(self, action: #selector(seeMore(_:)), for: .touchUpInside)
        
        return cell
    }

    // See PopUp after touching See more button
    func seeMore(_ sender: UIButton) {
        let charity = charityList?.launchedCharites[sender.tag]
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let singleCharityViewController: SingleCharityViewController = storyboard.instantiateViewController(withIdentifier: "SingleCharityViewController") as! SingleCharityViewController

        singleCharityViewController.charity = charity
        
        self.navigationController?.pushViewController(singleCharityViewController, animated: true)
    }
    
    // Reload Data 
    override func viewWillAppear(_ animated: Bool) {
        charityList = CharityList.main
        
        charityList?.update()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        charityList = nil
    }
}

class SingleCharityViewController: UIViewController {
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var charityImage: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var donateButton: UIButton!
    @IBOutlet var requestLabel: UILabel!
    
    var charity: Charity? = nil
    
    var isDonated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyLabel.text = charity?.company!
        charityImage.image = charity?.image
        captionLabel.text = charity?.caption!
        
        // Rounded Button 
        donateButton.layer.cornerRadius = 20
        donateButton.layer.shadowColor = UIColor.black.cgColor
        donateButton.layer.shadowOpacity = 0.3
        donateButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        donateButton.layer.shadowRadius = 4
        
        // Hide share Button
        shareButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(_:)))
        self.navigationItem.rightBarButtonItem = shareButton
        shareButton.isEnabled = false
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
            let charity = self.charity
            let donatedSteps = ProfileManager.myProfile.profile.currentSteps
            ProfileManager.myProfile.profile.donate(steps: donatedSteps!, for: charity!)
            CharityList.main.update()
            self.isDonated = true
            self.shareButton.isEnabled = true
            self.changeCaptionAfterDonated(donatedSteps!)
            self.requestLabel.isHidden = true
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
        let caption = "\(self.charity?.company!) donated \(moneyInString) for \(self.charity?.title!) project. \n\n Thank you for your donation!"
        
        self.captionLabel.text = caption
        self.donateButton.isHidden = true
    }
    
    var shareButton: UIBarButtonItem!
    
    func share(_ sender: UIButton){
        
        if !isDonated {
            return
        }
        guard self.charity != nil else {
            return
        }
        
        let charity = self.charity
        let post = CharityPost(charity: charity!)
        
        PostsList.main.add(post)
        
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: true)
    }
}

