//
//  MealChallengeTableViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-25.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class MealChallengeTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var challengeList = ChallengeList.mealChallengeList
    
    var activeChallenges = [Challenge]()
    var pendingChallenges = [Challenge]()
    var pastChallenges = [Challenge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.activeChallenges = self.filterChallenge(byStatus: .active)
        self.pendingChallenges = self.filterChallenge(byStatus: .pending)
        self.pastChallenges = self.filterChallenge(byStatus: .finishedVoting)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.activeChallenges = self.filterChallenge(byStatus: .active)
        self.pendingChallenges = self.filterChallenge(byStatus: .pending)
        self.pastChallenges = self.filterChallenge(byStatus: .finishedVoting)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func filterChallenge(byStatus filterStatus: ChallengeStatus) -> [Challenge]{
        let challenges = ChallengeList.mealChallengeList.allChallenges.filter({ (challenge: Challenge) -> Bool in
            let status = challenge.status
            return (status == filterStatus)
        })
        return challenges
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return activeChallenges.count
        case 1:
            return pendingChallenges.count
        case 2:
            return pastChallenges.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let challenge = activeChallenges[indexPath.row] as! IndividualMealChallenge
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealActiveCell", for: indexPath) as! ActiveMealChallengeCell
            
            cell.titleLabel.text = challenge.title
            cell.userImage.image = ProfileManager.myProfile.profile.picture
            cell.userImage.layer.masksToBounds = true
            cell.userImage.layer.cornerRadius = CGFloat(21.5)
            
            cell.userNameLabel.text = ProfileManager.myProfile.myself.fullName
            
            if challenge.sender == ProfileManager.myProfile.myself {
                cell.friendImage.image = challenge.receiver?.profile.picture
                cell.friendNameLabel.text = challenge.receiver?.fullName
            }
            else {
                cell.friendImage.image = challenge.sender.profile.picture
                cell.friendNameLabel.text = challenge.sender.fullName
            }
            
            cell.friendImage.layer.masksToBounds = true
            cell.friendImage.layer.cornerRadius = CGFloat(21.5)
            cell.takePhotoButton.tag = indexPath.row
            cell.takePhotoButton.addTarget(self, action: #selector(takePhoto(_:)), for: .touchUpInside)
            return cell
        
        case 1:
            let challenge = pendingChallenges[indexPath.row] as! IndividualMealChallenge
            if challenge.sender == ProfileManager.myProfile.myself {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MealPendingSentCell", for: indexPath) as! PendingMealSentChallengeCell
                cell.titleLabel.text = challenge.title
                cell.userImage.image = ProfileManager.myProfile.profile.picture
                cell.userImage.layer.masksToBounds = true
                cell.userImage.layer.cornerRadius = CGFloat(21.5)
                cell.userNameLabel.text = ProfileManager.myProfile.myself.fullName
                cell.friendImage.image = challenge.receiver?.profile.picture
                cell.friendImage.layer.masksToBounds = true
                cell.friendImage.layer.cornerRadius = CGFloat(21.5)
                cell.friendNameLabel.text = challenge.receiver?.fullName
                
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MealPendingSentCell", for: indexPath) as! PendingMealReceivedChallengeCell
                cell.titleLabel.text = challenge.title
                cell.userImage.image = ProfileManager.myProfile.profile.picture
                cell.userImage.layer.masksToBounds = true
                cell.userImage.layer.cornerRadius = CGFloat(21.5)
                cell.userNameLabel.text = ProfileManager.myProfile.myself.fullName
                cell.friendImage.image = challenge.sender.profile.picture
                cell.friendImage.layer.masksToBounds = true
                cell.friendImage.layer.cornerRadius = CGFloat(21.5)
                cell.friendNameLabel.text = challenge.sender.fullName
                cell.ignoreButton.tag = indexPath.row
                
                cell.acceptButton.tag = indexPath.row
                
                return cell
            }
        default:
            return UITableViewCell()
        }

        // Configure the cell...

    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Seravek-Medium", size: 18)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Active Challenges"
        case 1:
            return "Upcoming Challenges"
        case 2:
            return "Past Challenges"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func takePhoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        // If the device has a camera, take a picture; otherwise,
        // just pick from the library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .savedPhotosAlbum
        }
        
        imagePicker.delegate = self
        
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: { () -> Void in
            imagePicker.view.tag = sender.tag
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        dismiss(animated: true, completion: nil)
        
        // Push Post Detail View Controller
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController {
            //print("DONE TAKING PHOTO!")
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
                viewController.isChallenge = true
                viewController.challengIndex = picker.view.tag
                viewController.image = image
            }
        }
    }

}

class ActiveMealChallengeCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var friendImage: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    
    @IBOutlet var takePhotoButton: UIButton!
}

class PendingMealSentChallengeCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var friendImage: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
}

class PendingMealReceivedChallengeCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var friendImage: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var ignoreButton: UIButton!
    @IBOutlet var acceptButton: UIButton!
    
}
