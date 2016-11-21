//
//  PostDetailViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-10.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

protocol PostDetailEnteredDelegate {
    func userDidEnterMeal(_ meal: MealPost)
}

class PostDetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var imageTaken: UIImageView!
    
    var image: UIImage!
    var mealType: MealType!
    
    var delegate: PostDetailEnteredDelegate? = nil
    
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load image into image view
        imageTaken.image = image
        
        
        // Dynamically fit button text size
        for button in mealTypeButtons {
            button.titleLabel?.minimumScaleFactor = 0.2
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.backgroundColor = UIColor.clear
            button.layer.cornerRadius = 9
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1).cgColor
            //
            button.addTarget(self, action: #selector(chooseMealType(_:)), for: .touchUpInside)
        }
        
        // Initialize meal type
        mealTypeButtons[0].backgroundColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1)
        mealTypeButtons[0].setTitleColor(UIColor.white, for: .normal)
        mealType = MealType.breakfast
        
        // Text Field Delegation
        captionTextField.delegate = self
        
        //Rounded Button 
        self.saveButton.layer.cornerRadius = 20
    }
    
    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var mealTypeButtons: [UIButton]!
    
    
    func chooseMealType(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1)
        sender.setTitleColor(UIColor.white, for: .normal)
        
        for button in mealTypeButtons where button != sender{
            button.backgroundColor = UIColor.clear
            button.setTitleColor(UIColor.black, for: .normal)
        }
        
        if let index = mealTypeButtons.index(of: sender) {
            switch index {
            case 0:
                mealType = MealType.breakfast
            case 1:
                mealType = MealType.lunch
            case 2:
                mealType = MealType.dinner
            case 3:
                mealType = MealType.snack
            case 4:
                mealType = MealType.other
            default:
                mealType = MealType.breakfast
            }
        }
    }
    
    
    // After press Post button
    @IBAction func postMeal(_ sender: Any) {
        let postImage = self.image
        var caption = ""
        if captionTextField.text != nil {
            caption = captionTextField.text!
        }
        let type = mealType
        if (delegate != nil) {
            
            print("DONE")
            
            let post = MealPost(image: postImage, caption: caption, type: type!)
            
            delegate!.userDidEnterMeal(post)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        captionTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    // MARK: Implement food tags view
    @IBOutlet var foodTagsView: UIStackView!
    
    func loadTags() {
        for view in self.foodTagsView.subviews as [UIView] {
            if let stackView = view as? UIStackView {
                stackView.alignment = .center
                stackView.distribution = .fillProportionally
                
                stackView.addSubview(<#T##view: UIView##UIView#>)
            }
        }
    }
}
