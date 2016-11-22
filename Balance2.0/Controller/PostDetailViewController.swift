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
        for button in self.mealTypeButtons {
            button.titleLabel?.minimumScaleFactor = 0.2
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.backgroundColor = UIColor.clear
            button.layer.cornerRadius = 9
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1).cgColor
            button.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
            
            button.addTarget(self, action: #selector(chooseMealType(_:)), for: .touchUpInside)
        }
        
        // Initialize meal type
        mealTypeButtons[0].backgroundColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1)
        mealTypeButtons[0].setTitleColor(UIColor.white, for: .normal)
        mealType = MealType.breakfast
        
        // Text Field Delegation
        captionTextField.delegate = self
        
        // ADd food tags into view
        self.loadTags()
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
    
    // After press post
    @IBAction func postMeal(_ sender: Any) {
        let postImage = self.image
        var caption = ""
        if captionTextField.text != nil {
            caption = captionTextField.text!
        }
        let type = mealType
        if (delegate != nil) {
            
            print("DONE")
            
            let tags = self.chosenTagList
            let post = MealPost(image: postImage, caption: caption, type: type!, tags: tags)
            
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
    var foodTagList = FoodTagList.main
    
    func loadTags() {
        let numberOfTags = FoodTagList.main.foodTags.count
        let numberOfRows = Int(ceilf(Float(numberOfTags)/4))
        var index = 0
        for _ in 0..<numberOfRows {
            let stackView = UIStackView()
            let heightConstraint = stackView.heightAnchor.constraint(equalToConstant: 22)
            heightConstraint.isActive = true
            stackView.alignment = .center
            stackView.distribution = .fillProportionally
            stackView.spacing = 10
            for i in 0..<4 {
                if index + i < numberOfTags {
                    let tagButton = UIButton()
                    tagButton.setTitle(foodTagList.foodTags[index+i].name, for: .normal)
                    tagButton.titleLabel?.minimumScaleFactor = 0.5
                    tagButton.titleLabel?.adjustsFontSizeToFitWidth = true
                    tagButton.tag = index + i
                    tagButton.layer.cornerRadius = 9
                    tagButton.layer.borderColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1).cgColor
                    tagButton.layer.borderWidth = 1
                    tagButton.backgroundColor = UIColor.clear
                    tagButton.setTitleColor(UIColor.black, for: .normal)
                    tagButton.addTarget(self, action: #selector(chooseTag(_:)), for: .touchUpInside)
            
                    tagButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
                    
                    stackView.addArrangedSubview(tagButton)
                }
            }
            index += 4
            self.foodTagsView.addArrangedSubview(stackView)
        }
    }
    
    var chosenTagList = FoodTagList.logged
    var mealTagList = FoodTagList()
    func chooseTag(_ sender: UIButton) {
        if sender.titleColor(for: .normal) == UIColor.black {
            sender.backgroundColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1)
            sender.setTitleColor(UIColor.white, for: .normal)
            chosenTagList.add(tag: foodTagList.foodTags[sender.tag])
            mealTagList.add(tag: foodTagList.foodTags[sender.tag])
            return
        }
        sender.backgroundColor = UIColor.clear
        sender.setTitleColor(UIColor.black, for: .normal)
        chosenTagList.remove(tag: foodTagList.foodTags[sender.tag])
        mealTagList.remove(tag: foodTagList.foodTags[sender.tag])
    }
}
