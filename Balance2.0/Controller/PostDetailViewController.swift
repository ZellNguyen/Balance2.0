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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load image into image view
        imageTaken.image = image
        
        
        // Dynamically fit button text size
        for button in mealTypeButtons {
            button.titleLabel?.minimumScaleFactor = 0.2
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            
            //
            button.addTarget(self, action: #selector(chooseMealType(_:)), for: .touchUpInside)
        }
        
        // Initialize meal type
        mealTypeButtons[0].backgroundColor = UIColor.blue
        mealType = MealType.breakfast
        
        // Text Field Delegation
        captionTextField.delegate = self
    }
    
    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var mealTypeButtons: [UIButton]!
    
    
    func chooseMealType(_ sender: UIButton) {
        sender.backgroundColor = UIColor.blue
        
        for button in mealTypeButtons where button != sender{
            button.backgroundColor = UIColor.clear
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
        captionTextField.resignFirstResponder()
    }
}
