//
//  ProfileViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-18.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

struct PickerViewSetting {
    var numberOfComponents: Int! = 0
    var numberOfRowInComponents: [Int]! = [Int]()
    var options: [[String]]! = [[String]]()
}

enum ProfileField: String {
    case gender
    case height
    case weight
    case birthdate
    case specialDiet
    case none
}

class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerViewSetting: PickerViewSetting = PickerViewSetting()
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var datePickerView: UIDatePicker!
    var blurEffectView = UIView()
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var toolBarForPicker: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set up Picker View
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        self.pickerView.isHidden = true
        self.toolBarForPicker.isHidden = true
        
        // Set up Date Picker View
        self.datePickerView.isHidden = true
        self.datePickerView.backgroundColor = UIColor.white
        
        // Dark Blur Background
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.insertSubview(blurEffectView, belowSubview: pickerView)
        blurEffectView.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPicker(_:)))
        self.blurEffectView.addGestureRecognizer(tap)
        
        // Profile Image
        self.view.sendSubview(toBack: profileImage)
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
    
    // MARK:  Set up Picker View
    var selectedField = ProfileField.none
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 72.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerViewSetting.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewSetting.numberOfRowInComponents[component]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let picker = UILabel()
        
        picker.textAlignment = .center
        picker.adjustsFontSizeToFitWidth = true
        
        picker.attributedText = NSAttributedString(string: pickerViewSetting.options[component][row])
        
        return picker
    }
    
    // MARK: Select Gender by picker view
    
    @IBAction func selectGender(_ sender: Any) {
        selectedField = .gender
        
        let genderOptions: [String]! = ["Male", "Female"]
        
        pickerViewSetting.numberOfComponents = 1
        pickerViewSetting.numberOfRowInComponents = [2]
        pickerViewSetting.options = [genderOptions]
        //print(pickerViewSetting.options[0][0])
        
        pickerView.isHidden = false
        toolBarForPicker.isHidden = false
        pickerView.reloadAllComponents()
        
        // dim Background
        self.dimBackground()
        
        //Reset label
        strings = ["Male"]
    }

    // MARK: Select Height
    
    @IBAction func selectHeight(_ sender: Any) {
        selectedField = .height
        
        let	biggerHeightNumbers: [Int]! = [1,2,3,4,5,6,7,8]
        let biggerHeightUnits: [String]! = ["ft", "m"]
        var smallerHeightNumbers: [Int]! {
            var numbers = [Int]()
            for i in 0..<100 {
                numbers.append(i)
            }
            return numbers
        }
        let smallerHeightUnits: [String]! = ["in", "cm"]
        
        pickerViewSetting.numberOfComponents = 4
        pickerViewSetting.numberOfRowInComponents = [biggerHeightNumbers.count, biggerHeightUnits.count, smallerHeightNumbers.count, smallerHeightUnits.count]
        
        var biggerString = [String!]()
        for number in biggerHeightNumbers {
            biggerString.append(String(number))
        }
        
        var smallerString = [String!]()
        for number in smallerHeightNumbers {
            smallerString.append(String(format: "%02d", number))
        }
        
        pickerViewSetting.options = [biggerString, biggerHeightUnits, smallerString, smallerHeightUnits]
        
        pickerView.isHidden = false
        toolBarForPicker.isHidden = false
        pickerView.reloadAllComponents()
        
        // dim Background
        self.dimBackground()
        
        //Reset label
        strings = ["1", "ft", "00", "in"]
    }
    
    
    // MARK: Select Weight
    @IBAction func setWeight(_ sender: Any) {
        selectedField = .weight
        
        let weightUnits: [String]! = ["lb", "kg"]
        var weightNumbers: [String]! {
            var numbers = [String]()
            for i in 0..<301 {
                numbers.append(String(format: "%03d", i))
            }
            return numbers
        }
        
        pickerViewSetting.numberOfComponents = 2
        pickerViewSetting.numberOfRowInComponents = [weightNumbers.count, weightUnits.count]
        
        pickerViewSetting.options = [weightNumbers, weightUnits]
        
        pickerView.isHidden = false
        toolBarForPicker.isHidden = false
        pickerView.reloadAllComponents()
        
        // dim Background
        self.dimBackground()
        
        //Reset label
        strings = ["001", "lb"]
    }
    
    // MARK: Select Birthdate
    
    @IBAction func selectDOB(_ sender: Any) {
        selectedField = .birthdate
        
        datePickerView.isHidden = false
        toolBarForPicker.isHidden = false
        
        // dim Background
        self.dimBackground()
    }
    
    // MARK: Done Button
    
    // Change Button Label and Data after picking
    @IBOutlet var genderButton: UIButton!
    @IBOutlet var heightButton: UIButton!
    @IBOutlet var weightButton: UIButton!
    @IBOutlet var birthdateButton: UIButton!
    
    var strings = [String]()
    
    @IBAction func done(_ sender: Any) {
        dismissPicker()
        var label = ""
        
        for string in strings {
            label += "\(string) "
        }
        
        switch selectedField {
        case .gender:
            save(gender: strings[0])
            genderButton.setTitle(label, for: .normal)
        case .height:
            save(height: strings)
            heightButton.setTitle(label, for: .normal)
        case .weight:
            save(weight: strings)
            weightButton.setTitle(label, for: .normal)
        default:
            break
        }
    }
    
    // Save gender to profile
    func save(gender: String){
        switch gender {
        case "Male":
            ProfileManager.myProfile.profile.gender = Gender.male
        case "Female":
            ProfileManager.myProfile.profile.gender = Gender.female
        default:
            break
        }
    }
    
    
    // Save Height to profile
    func save(height: [String]) {
        var amount: Float = 0.0
        switch height[1] {
        case "ft":
            amount += Float(height[0])! * 30.48
        case "m":
            amount += Float(height[0])! * 100.0
        default:
            break
        }
        
        switch height[3] {
        case "in":
            amount += Float(height[2])! * 2.54
        case "cm":
            amount += Float(height[2])!
        default:
            break
        }
        
        ProfileManager.myProfile.profile.heightInCm = amount
    }
    
    // Save Weight to profile
    func save(weight: [String]){
        var amount: Float = 0
        switch weight[1] {
        case "lb":
            amount += Float(weight[0])! * 0.453592
        case "kg":
            amount += Float(weight[0])!
        default:
            break
        }
        
        ProfileManager.myProfile.profile.weightInKg = amount
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        strings[component] = pickerViewSetting.options[component][row]
    }
    
    // MARK: Select date of birth
    @IBAction func selectDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: sender.date)
        birthdateButton.setTitle(strDate, for: .normal)
        
        ProfileManager.myProfile.profile.dob = sender.date
    }
    
    // MARK: Select Special Diet
    @IBAction func selectSpecialDiet(_ sender: Any) {
        selectedField = .specialDiet
        performSegue(withIdentifier: "ShowDietList", sender: sender)
    }
    
    // MARK: Perform Darker Background
    func dimBackground() {
        blurEffectView.isHidden = false
    }
    
    // MARK: stop editing
    func dismissPicker(_ sender: UITapGestureRecognizer? = nil) {
        blurEffectView.isHidden = true
        pickerView.isHidden = true
        toolBarForPicker.isHidden = true
        datePickerView.isHidden = true
    }
    
    // END EDITING
    @IBAction func finish(_ sender: Any) {
        let alertBox = UIAlertController(title: "", message: "All the unfilled fields will be set to default. Are you sure?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.performSegue(withIdentifier: "showNewsFeedFromRegistration", sender: self)
        })
        
        alertBox.addAction(cancelAction)
        alertBox.addAction(okAction)
        
        if genderButton.title(for: .normal) == "Select" || heightButton.title(for: .normal) == "Select" || weightButton.title(for: .normal) == "Select" || birthdateButton.title(for: .normal) == "Select" {
            present(alertBox, animated: true, completion: nil)
            return
        }
        
        performSegue(withIdentifier: "showNewsFeedFromRegistration", sender: self)
    }
    
}

class SpecialDietTableView: UITableViewController {
    var dietList = SpecialDietList.main.specialDiets
    var checkBoxes: [UIImage] = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCheckBoxes()
    }
    
    func loadCheckBoxes() {
        for _ in dietList {
            let checkBox = UIImage.init(named: "default-image-post")
            checkBoxes.append(checkBox!)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dietList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialDietCell") as! SpecialDietCell
    
        cell.checkBox.image = checkBoxes[indexPath.row]
        cell.dietLabel.text = dietList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkBoxes[indexPath.row] = UIImage.init(named: "default-image-post")!
        print("Checked")
    }
}

class SpecialDietCell: UITableViewCell {
    @IBOutlet var checkBox: UIImageView!
    @IBOutlet var dietLabel: UILabel!
}
