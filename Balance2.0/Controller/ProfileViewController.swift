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

class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerViewSetting: PickerViewSetting = PickerViewSetting()
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var datePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set up Picker View
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.pickerView.isHidden = true
        
        // Set up Date Picker View
        self.datePickerView.isHidden = true
    
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
        let genderOptions: [String]! = ["Male", "Female"]
        
        pickerViewSetting.numberOfComponents = 1
        pickerViewSetting.numberOfRowInComponents = [2]
        pickerViewSetting.options = [genderOptions]
        //print(pickerViewSetting.options[0][0])
        
        pickerView.isHidden = false
        
        pickerView.reloadAllComponents()
    }

    // MARK: Select Height
    
    @IBAction func selectHeight(_ sender: Any) {
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
        pickerView.reloadAllComponents()
    }
    
    
    // MARK: Select Weight
    @IBAction func setWeight(_ sender: Any) {
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
        pickerView.reloadAllComponents()
    }
    
    // MARK: Select Birthdate
    
    
    
    
}
