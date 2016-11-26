//
//  ViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-10.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PostDetailEnteredDelegate {
    
    var meal: MealPost? = nil {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Go back to log in view if user has not logged in
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if !isLoggedIn {
            self.performSegue(withIdentifier: "ShowLogIn", sender: self)
            return
        }
        
        // Store data for profile manager object
        let email = UserDefaults.standard.string(forKey: "userEmail")
        let fullName = UserDefaults.standard.string(forKey: "userFullName")
        let friendListData = UserDefaults.standard.data(forKey: "userFriendList")
        let friendList = NSKeyedUnarchiver.unarchiveObject(with: friendListData!) as! FriendList
        
        let profileData = UserDefaults.standard.data(forKey: "userProfile")
        let profile = NSKeyedUnarchiver.unarchiveObject(with: profileData!) as! UserProfile
        
        
        ProfileManager.myProfile.login(email: email!, fullName: fullName!, friendList: friendList, profile: profile)
        
        // Style Bar Buttons
        self.plusMeal.backgroundColor = UIColor.white
        self.plusMeal.layer.borderColor = UIColor.darkGray.cgColor
        self.plusMeal.layer.borderWidth = 0.5
        
        self.plusMealChallenge.layer.borderColor = UIColor.darkGray.cgColor
        self.plusMealChallenge.layer.borderWidth = 0.5
        
        self.plusStepChallenge.layer.borderColor = UIColor.darkGray.cgColor
        self.plusStepChallenge.layer.borderWidth = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.plusMeal.backgroundColor = UIColor.white
        self.plusMeal.setTitleColor(UIColor.blue, for: .normal)
    }

    @IBAction func takePhoto(_ sender: Any) {
        let button = sender as! UIButton
        button.backgroundColor = UIColor(red: 68/255, green: 211/255, blue: 174/255, alpha: 1)
        //button.titleLabel?.textColor = UIColor.white
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
        present(imagePicker, animated: true, completion: nil)
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
                viewController.image = image
                viewController.delegate = self
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let newsfeed = self.childViewControllers[0] as! NewsFeedController
        if let _ = meal {
            newsfeed.postsList.add(meal!)
        }
        newsfeed.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Prevent post duplication
        self.meal = nil
    }
    
    func userDidEnterMeal(_ meal: MealPost) {
        self.meal = meal
    }


    // MARK: Style Buttons
    
    @IBOutlet var plusMeal: UIButton!
    @IBOutlet var plusMealChallenge: UIButton!
    @IBOutlet var plusStepChallenge: UIButton!
    
}

