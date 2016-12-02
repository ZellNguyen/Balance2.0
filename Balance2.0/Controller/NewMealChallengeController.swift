//
//  NewMealChallengeController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-25.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class NewMealChallengeController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITextFieldDelegate {
    
    @IBOutlet var friendTableView: UITableView!
    
    var friendList = ProfileManager.myProfile.friendList
    var filteredFriend: [UserAccount]? = [UserAccount]()
    
    @IBOutlet var toolBarPicker: UIToolbar!
    @IBOutlet var senderLabel: UILabel!
    @IBOutlet var senderImage: UIImageView!
    @IBOutlet var friendImage: UIImageView!
    
    @IBOutlet var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.friendTableView.delegate = self
        self.friendTableView.dataSource = self
        self.friendTableView.reloadData()
        
        // TextField Delegate
        self.messageTextField.delegate = self
        self.messageTextField.backgroundColor = UIColor.white
        self.messageTextField.clipsToBounds = false
        let lowerBorder = CALayer()
        lowerBorder.backgroundColor = UIColor.lightGray.cgColor
        lowerBorder.frame = CGRect(x: 0, y: messageTextField.frame.height, width: messageTextField.frame.width, height: 1.0)
        let rightBorder = CALayer()
        rightBorder.backgroundColor = UIColor.lightGray.cgColor
        rightBorder.frame = CGRect(x: messageTextField.frame.width, y: 0, width: 1.0, height: messageTextField.frame.height)
        self.messageTextField.layer.addSublayer(lowerBorder)
        self.messageTextField.layer.addSublayer(rightBorder)
        
        // Date label
        self.toDateLabel.backgroundColor = UIColor.white
        let lowerBorder1 = CALayer()
        lowerBorder1.backgroundColor = UIColor.lightGray.cgColor
        lowerBorder1.frame = CGRect(x: 0, y: toDateLabel.frame.height, width: toDateLabel.frame.width, height: 1.0)
        let rightBorder1 = CALayer()
        rightBorder1.backgroundColor = UIColor.lightGray.cgColor
        rightBorder1.frame = CGRect(x: toDateLabel.frame.width, y: 0, width: 1.0, height: toDateLabel.frame.height)
        self.toDateLabel.layer.addSublayer(lowerBorder1)
        self.toDateLabel.layer.addSublayer(rightBorder1)
        
        self.fromDateLabel.backgroundColor = UIColor.white
        let lowerBorder2 = CALayer()
        lowerBorder2.backgroundColor = UIColor.lightGray.cgColor
        lowerBorder2.frame = CGRect(x: 0, y: fromDateLabel.frame.height, width: fromDateLabel.frame.width, height: 1.0)
        let rightBorder2 = CALayer()
        rightBorder2.backgroundColor = UIColor.lightGray.cgColor
        rightBorder2.frame = CGRect(x: fromDateLabel.frame.width, y: 0, width: 1.0, height: fromDateLabel.frame.height)
        
        self.fromDateLabel.layer.addSublayer(lowerBorder2)
        self.fromDateLabel.layer.addSublayer(rightBorder2)
        
        // Challenge Field
        self.titleTextField.delegate = self
        self.titleTextField.backgroundColor = UIColor.white
        self.titleTextField.clipsToBounds = false
        let lowerBorder3 = CALayer()
        lowerBorder3.backgroundColor = UIColor.lightGray.cgColor
        lowerBorder3.frame = CGRect(x: 0, y: titleTextField.frame.height, width: titleTextField.frame.width, height: 1.0)
        let rightBorder3 = CALayer()
        rightBorder3.backgroundColor = UIColor.lightGray.cgColor
        rightBorder3.frame = CGRect(x: titleTextField.frame.width, y: 0, width: 1.0, height: titleTextField.frame.height)
        self.titleTextField.layer.addSublayer(lowerBorder3)
        self.titleTextField.layer.addSublayer(rightBorder3)

        
        
        // Hide elements
        self.fromDatePicker.isHidden = true
        self.fromDatePicker.backgroundColor = UIColor.white
        self.toDatePicker.isHidden = true
        self.toDatePicker.backgroundColor = UIColor.white
        self.toolBarPicker.isHidden = true
        //self.friendNameLabel.isHidden = true
        
        // Initialize image
        self.senderImage.image = ProfileManager.myProfile.profile.picture
        self.senderImage.layer.masksToBounds = true
        self.senderImage.layer.cornerRadius = CGFloat(43)
        self.senderLabel.text = ProfileManager.myProfile.myself.fullName
        
        self.friendImage.layer.masksToBounds = true
        self.friendImage.layer.cornerRadius = CGFloat(43)
        
        // Date Picker
        self.fromDatePicker.minimumDate = Date()
        self.toDatePicker.minimumDate = Date()
        self.fromDatePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        self.toDatePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 30, to: Date())

        // Send Button
        self.sendButton.layer.cornerRadius = 20
        self.sendButton.layer.shadowColor = UIColor.black.cgColor
        self.sendButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.sendButton.layer.shadowOpacity = 0.5
        self.sendButton.layer.shadowRadius = 4
        
        // Search Bar
        self.friendSearchBar.setValue("Done", forKey: "_cancelButtonText")
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.friendList = ProfileManager.myProfile.friendList
        self.filteredFriend = [UserAccount]()
        self.friendTableView.isHidden = true
        self.friendSearchBar.isHidden = true
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredFriend!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = isSearchActive ? self.friendTableView.dequeueReusableCell(withIdentifier: "mealFriendCell")! as UITableViewCell : UITableViewCell()
        let friend = self.filteredFriend?[indexPath.row]
        
        cell.textLabel?.text = friend?.fullName
        
        return cell
    }
    
    // Choose friend to challenge
    @IBOutlet var friendSearchBar: UISearchBar!
    
    
    @IBOutlet var friendNameLabel: UILabel!
    
    @IBAction func findFriend(_ sender: UITapGestureRecognizer) {
        print("TAP")
        self.friendSearchBar.isHidden = false
        self.friendTableView.isHidden = false
    }
    
    var receiver: UserAccount? = nil
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = filteredFriend?[indexPath.row]
        print("Click")
        receiver = friend
        self.isSearchActive = false
        self.friendImage.image = friend?.profile.picture
        self.friendNameLabel.text = friend?.fullName
        //self.friendNameLabel.isHidden = false
        self.friendNameLabel.textColor = UIColor.black
        self.friendTableView.isHidden = true
        self.searchDisplayController?.isActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearchActive = false
        self.friendTableView.isHidden = true
        self.friendSearchBar.isHidden = true
    }
    
    // MARK: Search
    var isSearchActive = false
    
    func filterContentForSearchText(searchText: String){
        self.filteredFriend = (self.friendList?.allFriends.filter( {(friend: UserAccount) -> Bool in
            let nameMatch = friend.fullName.range(of: searchText)
            let emailMatch = friend.email.range(of: searchText)
            let isSelected = receiver == friend
            
            return (((nameMatch != nil) || (emailMatch != nil)) && !isSelected)
        }))!
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        isSearchActive = true
        self.filterContentForSearchText(searchText: searchString!)
        self.friendTableView.reloadData()
        
        return true
    }
    
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    
    @IBAction func endEditing(_ sender: Any) {
        dismissKeyboard()
        
        self.toolBarPicker.isHidden = true
        self.toDatePicker.isHidden = true
        self.fromDatePicker.isHidden = true
    }
    
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: Text Fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    // MARK: Date Picker
    @IBOutlet var fromDatePicker: UIDatePicker!
    @IBOutlet var toDatePicker: UIDatePicker!
    
    @IBOutlet var fromDateLabel: UILabel!
    @IBOutlet var toDateLabel: UILabel!
    
    var fromDate: Date? = nil
    var toDate: Date? = nil
    
    @IBAction func showFromDatePicker(_ sender: Any) {
        self.toolBarPicker.isHidden = false
        fromDatePicker.isHidden = false
    }
    @IBAction func showToDatePicker(_ sender: Any) {
        self.toolBarPicker.isHidden = false
        toDatePicker.isHidden = false
    }
    
    @IBAction func chooseFromDate(_ sender: UIDatePicker) {
        let fromDate = sender.date
        self.fromDateLabel.text = DateFormatter.localizedString(from: fromDate, dateStyle: .medium, timeStyle: .none)
        self.fromDate = fromDate
    }
    
    @IBAction func chooseToDate(_ sender: UIDatePicker) {
        let toDate = sender.date
        self.toDateLabel.text = DateFormatter.localizedString(from: toDate, dateStyle: .medium, timeStyle: .none)
        self.toDate = toDate
    }
    
    @IBAction func endDatePicker(_ sender: UIBarButtonItem) {
        self.fromDateLabel.text = DateFormatter.localizedString(from: self.fromDatePicker.date, dateStyle: .medium, timeStyle: .none)
        self.fromDate = fromDatePicker.date
        fromDatePicker.isHidden = true
        self.toDateLabel.text = DateFormatter.localizedString(from: self.toDatePicker.date, dateStyle: .medium, timeStyle: .none)
        self.toDate = toDatePicker.date
        toDatePicker.isHidden = true
        toolBarPicker.isHidden = true
    }
    
    // MARK: Save the challenge
    @IBAction func save(_ sender: Any) {
        let alertBox = UIAlertController(title: "Failed", message: "All fields must be filled", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertBox.addAction(okAction)
        
        let message = messageTextField.text ?? ""
        let title = titleTextField.text ?? ""
        
        if message.isEmpty || title.isEmpty || fromDate == nil || toDate == nil || receiver == nil {
            present(alertBox, animated: true, completion: nil)
            return
        }
        
        let dateAlertBox = UIAlertController(title: "Invalid date", message: "Invalid start and end dates", preferredStyle: .alert)
        dateAlertBox.addAction(okAction)
        
        if self.fromDate! > self.toDate! {
            present(dateAlertBox, animated: true, completion: nil)
            return
        }
        
        
        let newChallenge = IndividualMealChallenge(title: title, message: message, fromDate: fromDate!, toDate: toDate!, receiver: receiver!, option: MealChallengeOption.no_meat, link: nil)
    
        ChallengeList.mealChallengeList.add(challenge: newChallenge)
        
        let newChallengPost = MealChallengePost(caption: title, date: fromDate!, isReady: false, mealChallenge: [newChallenge])
        PostsList.hidden.add(newChallengPost)
        
        let pendingChallengeViewController = self.storyboard?.instantiateViewController(withIdentifier: "ExerciseChallengeViewController") as! ExerciseChallengeViewController
        var controllers = self.navigationController?.viewControllers
        let index = controllers?.index(of: self)
        controllers?[index!] = pendingChallengeViewController
        self.navigationController?.setViewControllers(controllers!, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.friendList = nil
        self.filteredFriend = nil
    }
    
}
