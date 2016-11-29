//
//  PostDetailViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-10.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var imageTaken: UIImageView!
    
    var image: UIImage?
    var mealType: MealType?
    
    var isChallenge = false
    var challengIndex: Int!

    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load image into image view
        imageTaken.image = image
        
        
        // Dynamically fit button text size
        var index = 0
        for button in self.mealTypeButtons {
            button.titleLabel?.minimumScaleFactor = 0.2
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.backgroundColor = UIColor.clear
            button.layer.cornerRadius = 9
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1).cgColor
            button.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
            
            button.addTarget(self, action: #selector(chooseMealType(_:)), for: .touchUpInside)
            button.tag = index
            index += 1
        }
        
        // Initialize meal type
        mealTypeButtons[0].backgroundColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1)
        mealTypeButtons[0].setTitleColor(UIColor.white, for: .normal)
        mealType = MealType.breakfast
        
        // Text Field Delegation
        captionTextField.delegate = self
        
        // ADd food tags into view
        self.loadTags()
        
        // Save Button
        saveButton.layer.cornerRadius = 20
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowOpacity = 0.5
        saveButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        saveButton.layer.shadowRadius = 4
    }
    
    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var mealTypeButtons: [UIButton]!
    
    
    func chooseMealType(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1)
        sender.titleLabel?.textColor = UIColor.white
        
        for button in mealTypeButtons{
            if button.tag != sender.tag {
                button.backgroundColor = UIColor.clear
                button.setTitleColor(UIColor.black, for: .normal)
            }
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
    
    @IBAction func save(_ sender: UIButton) {
        let postImage = self.image
        var caption = ""
        if captionTextField.text != nil {
            caption = captionTextField.text!
        }
        let type = mealType
        if !isChallenge {
            print("DONE")
            
            let tags = self.mealTagList
            let post = MealPost(image: postImage, caption: caption, type: type!, tags: tags!)
            self.loggedList?.add(tags: tags!)
            PostsList.main.add(post)
            print(PostsList.main.allPosts.count)
            self.navigationController?.popViewController(animated: true)
        }
        else {
            let tags = self.mealTagList
            let post = MealPost(image: postImage, caption: caption, type: type!, tags: tags!)
            
            let challenge = ChallengeList.mealChallengeList.allChallenges[challengIndex] as! IndividualMealChallenge
            let challengeCopy = challenge.copy() as! IndividualMealChallenge
            challengeCopy.post = post
            //challenge.status = ChallengeStatus.finished
            
            let challengePost = PostsList.mealChallenges.allPosts[challengIndex] as! MealChallengePost
            challengePost.mealChallenge.append(challengeCopy)
            if challengePost.mealChallenge.count == 2 {
                challengePost.isReady = true
                PostsList.main.add(challengePost)
            }
            //self.navigationController?.popViewController(animated: true)
            self.tabBarController?.selectedIndex = 0
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
        if !isChallenge {
            print("DONE")
            
            let tags = self.mealTagList
            let post = MealPost(image: postImage, caption: caption, type: type!, tags: tags!)
            self.loggedList?.add(tags: tags!)
            PostsList.main.add(post)
            
            self.navigationController?.popViewController(animated: true)
        }
        else {
            let tags = self.mealTagList
            let post = MealPost(image: postImage, caption: caption, type: type!, tags: tags!)
            
            let challenge = ChallengeList.mealChallengeList.allChallenges[challengIndex] as! IndividualMealChallenge
            let challengeCopy = challenge.copy() as! IndividualMealChallenge
            challengeCopy.post = post
            //challenge.status = ChallengeStatus.finished
            
            let challengePost = PostsList.mealChallenges.allPosts[challengIndex] as! MealChallengePost
            challengePost.mealChallenge.append(challengeCopy)
            if challengePost.mealChallenge.count == 2 {
                challengePost.isReady = true
                PostsList.main.add(challengePost)
            }
            //self.navigationController?.popViewController(animated: true)
            self.tabBarController?.selectedIndex = 0
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
    var foodTagList: FoodTagList? = FoodTagList.main
    
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
                    tagButton.setTitle(foodTagList?.foodTags[index+i].name, for: .normal)
                    tagButton.titleLabel?.font = UIFont(name: "Seravek", size: 14)
                    tagButton.titleLabel?.minimumScaleFactor = 0.5
                    //tagButton.titleLabel?.adjustsFontSizeToFitWidth = true
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
    
    var loggedList: FoodTagList? = FoodTagList.logged
    var mealTagList: FoodTagList? = FoodTagList()
    func chooseTag(_ sender: UIButton) {
        let tag = foodTagList?.foodTags[sender.tag].instantiate()
        if sender.titleColor(for: .normal) == UIColor.black {
            sender.backgroundColor = UIColor(red: 255/255, green: 157/255, blue: 9/255, alpha: 1)
            sender.setTitleColor(UIColor.white, for: .normal)
            mealTagList?.add(tag: tag!)
            return
        }
        sender.backgroundColor = UIColor.clear
        sender.setTitleColor(UIColor.black, for: .normal)
        mealTagList?.remove(tag: tag!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.image = nil
        self.mealType = nil
        self.loggedList = nil
        self.mealTagList = nil
        self.foodTagList = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loggedList = FoodTagList.logged
        self.mealTagList = FoodTagList()
        self.foodTagList = FoodTagList.main
    }
}
