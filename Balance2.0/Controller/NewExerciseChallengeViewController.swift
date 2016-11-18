//
//  NewChallengeViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-14.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class NewExerciseChallengeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet var friendTableView: UITableView!
    @IBOutlet var friendsStackView: UIStackView!
    
    var friendList = ProfileManager.myProfile.friendList
    var filteredFriend = [UserAccount]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.friendTableView.delegate = self
        self.friendTableView.dataSource = self
        self.friendTableView.reloadData()
        
        // Hide UIPickerView
        self.durationPicker.isHidden = true
        self.durationPicker.delegate = self
        self.durationPicker.dataSource = self
        let x = durationButton.frame.origin.x
        let y = durationButton.frame.origin.y
        self.durationPicker.frame = CGRect(x: x, y: y, width: 100, height: 70)
        self.durationPicker.center.y = self.durationButton.center.y
        self.durationPicker.backgroundColor = UIColor.white

        self.view.addSubview(durationPicker)
        
        // TextField Delegate
        self.messageTextField.delegate = self
        self.stepTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.friendTableView.isHidden = true
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredFriend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.friendTableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as UITableViewCell
        
        var friend: UserAccount
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            friend = self.filteredFriend[indexPath.row]
            cell.textLabel?.text = friend.fullName
            return cell
        }
            
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.friendTableView.isHidden = true
    }
    
    
    // Choose friend to challenge
    
    var selectedFriends = [UserAccount]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = filteredFriend[indexPath.row]
        print("Click")
        selectedFriends.append(friend)
        
        let friendLabel = UILabel()
        friendLabel.textAlignment = .center
        friendLabel.adjustsFontSizeToFitWidth = true
        friendLabel.attributedText = NSAttributedString(string: friend.fullName)
        friendsStackView.addArrangedSubview(friendLabel)
        print(selectedFriends.count)
        
        self.friendTableView.isHidden = true
    }
    
    // MARK: Search 
    
    func filterContentForSearchText(searchText: String){
        self.filteredFriend = (self.friendList?.allFriends.filter( {(friend: UserAccount) -> Bool in
            let nameMatch = friend.fullName.range(of: searchText)
            let emailMatch = friend.email.range(of: searchText)
            let isSelected = selectedFriends.contains(friend)
            
            return (((nameMatch != nil) || (emailMatch != nil)) && !isSelected)
        }))!
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        self.filterContentForSearchText(searchText: searchString!)
        self.friendTableView.reloadData()
        
        return true
    }
    
    // MARK: Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durationOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 72.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let picker = UILabel()
        
        picker.textAlignment = .center
        picker.adjustsFontSizeToFitWidth = true
        
        picker.attributedText = NSAttributedString(string: "\(durationOptions[row]) days")
        
        return picker
    }
    
    @IBOutlet var durationButton: UIButton!
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = "\(durationOptions[row]) days"
        durationButton.setTitle(title, for: .normal)
        self.duration = durationOptions[row]
    }
    
    // Duration Options
    var durationOptions = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var stepTextField: UITextField!
    var duration: Int! = 7
    var durationPicker: UIPickerView = UIPickerView()
    @IBAction func chooseDuration(_ sender: Any) {
        self.durationPicker.isHidden = false
        
    }
    
    @IBAction func save(_ sender: Any) {
        let alertBox = UIAlertController(title: "Failed", message: "All fields must be filled", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertBox.addAction(okAction)
        
        let message = messageTextField.text ?? ""
        let steps = stepTextField.text ?? ""
        let title = titleTextField.text ?? ""
        
        if message.isEmpty || steps.isEmpty || title.isEmpty {
            present(alertBox, animated: true, completion: nil)
            return
        }
        
        let deadline = NSDate(timeInterval: Double(duration * 86400), since: NSDate() as Date)
        
        for friend in selectedFriends {
            let newChallenge = IndividualExerciseChallenge(title: title, image: UIImage.init(named: "default-image-post"), message: message, goalSteps: Int(steps), receiver: friend, deadline: deadline)
            
            ChallengeList.exerciseChallengeList.add(challenge: newChallenge)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func endEditing(_ sender: Any) {
        dismissKeyboard()
        self.durationPicker.isHidden = true
    }
    
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: Text Fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString = textField.text ?? ""
        let newString = (currentString as NSString).replacingCharacters(in: range, with: string)
        return newString.characters.count <= 6
    }
}
