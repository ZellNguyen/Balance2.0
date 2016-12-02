//
//  DashboardViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-22.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class MealDashboardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var addMealButton: UIButton!
    @IBOutlet var mealHistoryButton: UIButton!
    @IBOutlet var mealChallengeButton: UIButton!

    @IBOutlet var tagProgressViews: [UIProgressView]!
    @IBOutlet var numberOfTagLabels: [UILabel]!
    
    @IBOutlet var tagLabels: [UILabel]!
    
    @IBOutlet var reportStackView: UIStackView!
    
    var loggedList: FoodTagList? = FoodTagList.logged
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Rounded buttons
        self.addMealButton.layer.cornerRadius = 20
        self.mealHistoryButton.layer.cornerRadius = 20
        self.mealChallengeButton.layer.cornerRadius = 20
        
        // Upscale the progress view
        for progressView in tagProgressViews {
            progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.3)
        }
        
        // Shadow of segmented Control
        segmentedControl.layer.shadowColor = UIColor.black.cgColor
        segmentedControl.layer.shadowOpacity = 0.3
        segmentedControl.layer.shadowOffset = CGSize(width: -2, height: 2)
        segmentedControl.layer.shadowRadius = 2
        segmentedControl.layer.cornerRadius = 8
        segmentedControl.layer.masksToBounds = true
        segmentedControl.selectedSegmentIndex = 0
        self.report(inDuration: 7)
        
        // Shadows of buttons
        addMealButton.layer.shadowColor = UIColor.black.cgColor
        addMealButton.layer.shadowOpacity = 0.3
        addMealButton.layer.shadowOffset = CGSize(width: -2, height: 2)
        addMealButton.layer.shadowRadius = 2
        
        mealHistoryButton.layer.shadowColor = UIColor.black.cgColor
        mealHistoryButton.layer.shadowOpacity = 0.3
        mealHistoryButton.layer.shadowOffset = CGSize(width: -2, height: 2)
        mealHistoryButton.layer.shadowRadius = 2
        
        mealChallengeButton.layer.shadowColor = UIColor.black.cgColor
        mealChallengeButton.layer.shadowOpacity = 0.3
        mealChallengeButton.layer.shadowOffset = CGSize(width: -2, height: 2)
        mealChallengeButton.layer.shadowRadius = 2
        
        self.view.layoutIfNeeded()
        
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
    
    @IBOutlet var segmentedControl: UISegmentedControl!

    @IBAction func changeTime(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.report(inDuration: 7)
        case 1:
            self.report(inDuration: 30)
        default:
            break
        }
    }
    
    func report(inDuration days: Int){
        let today = Date()
        let timeAgo = Calendar.current.date(byAdding: .day, value: -days, to: today)
        
        guard (self.loggedList?.foodTags.count)! > 0 else {
            return
        }
        
        var tagList = [FoodTag]()
        
        for tag in (self.loggedList?.foodTags)! {
            guard tag.date != nil else {
                continue
            }
            if tag.date! >= timeAgo! && tag.date! <= today {
                tagList.append(tag)
            }
        }
        
        var counts: [String:Int] = [:]
        
        for tag in tagList {
            counts[tag.name] = (counts[tag.name] ?? 0) + 1
        }
        
        let sortedCounts = counts.sorted(by: { $0.value > $1.value })
        var sortedTagNames = [String]()
        var sortedTagCounts = [Int]()
        var index = 0
        for (key, value) in sortedCounts {
            if index < 6 {
                sortedTagNames.append(key)
                sortedTagCounts.append(value)
                index += 1
            }
        }
        
        // Render 4 top tags
        let max = sortedTagCounts[0] == 0 ? 1 : sortedTagCounts[0]
        for i in 0..<4 {
            tagLabels[i].adjustsFontSizeToFitWidth = true
            if i < sortedTagCounts.count {
                tagLabels[i].text = sortedTagNames[i]
                tagProgressViews[i].progress = Float(sortedTagCounts[i])/Float(max) + 0.01
                numberOfTagLabels[i].text = String(sortedTagCounts[i])
            }
            else {
                tagLabels[i].text = ""
                tagProgressViews[i].progress = 0.01
                numberOfTagLabels[i].text = "0"
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.loggedList = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loggedList = FoodTagList.logged
    }
    
    @IBAction func takePhoto(_ sender: Any) {
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
                //viewController.delegate = self
            }
        }
    }
}

class ExerciseDashboardViewController: UIViewController {
    
    @IBOutlet var rankingButton: UIButton!
    @IBOutlet var charityButton: UIButton!
    @IBOutlet var challengeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingButton.layer.cornerRadius = 20
        charityButton.layer.cornerRadius = 20
        challengeButton.layer.cornerRadius = 20
        
        // Shadow of Buttons
        rankingButton.layer.shadowColor = UIColor.black.cgColor
        rankingButton.layer.shadowOpacity = 0.3
        rankingButton.layer.shadowOffset = CGSize(width: -2, height: 2)
        rankingButton.layer.shadowRadius = 2
        
        // Shadow of progress views
        charityButton.layer.shadowColor = UIColor.black.cgColor
        charityButton.layer.shadowOpacity = 0.3
        charityButton.layer.shadowOffset = CGSize(width: -2, height: 2)
        charityButton.layer.shadowRadius = 2
        
        // Shadow of progress views
        challengeButton.layer.shadowColor = UIColor.black.cgColor
        challengeButton.layer.shadowOpacity = 0.3
        challengeButton.layer.shadowOffset = CGSize(width: -2, height: 2)
        challengeButton.layer.shadowRadius = 2
        
        for index in 0..<7 {
            loadOneBar(daysAgo: 6-index)
        }
        
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
    
    @IBOutlet var stepBarStackViews: UIStackView!
    @IBOutlet var dateLabels: [UILabel]!
    @IBOutlet var stepLabels: [UILabel]!
    @IBOutlet var stepBarVerticalStackView: [UIStackView]!
    
    var stepArray: [Double]? = [Double]()
    
    func loadOneBar(daysAgo days: Int) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        let today = Date()
        let pastDate = calendar.date(byAdding: .day, value: -days, to: today)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM dd", options: 0, locale: nil)
        
        dateLabels[days].text = dateFormatter.string(from: pastDate!)
        dateLabels[days].adjustsFontSizeToFitWidth = true
        dateLabels[days].minimumScaleFactor = 0.2
        
        let startPastDate = calendar.startOfDay(for: pastDate!)
        
        let endPastDate = calendar.date(byAdding: .second, value: 3600*24-1, to: startPastDate)
        
        let view = UIView()
        
        StepCounter.main.authorizeHealthKit(completion: { (success, error) -> Void in
            if success {
                print("HealthKit authorization succeeded")
                StepCounter.main.countSteps(from: startPastDate, to: endPastDate!, completion: { (steps, error) -> Void in
                    self.stepLabels[days].text = String(steps)
                    //self.stepLabels[days].adjustsFontSizeToFitWidth = true
                    self.stepLabels[days].minimumScaleFactor = 0.2
                    
                    self.stepArray!.append(steps)
                    
                    let ratio = Float(steps/15000.0) > 1.0 ? 1.0 : Float(steps/15000.0)
                    let maxHeight = Float(200.0)
                    let layer = CAShapeLayer()
                    layer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 30, height: Int(maxHeight * ratio))).cgPath
                    layer.fillColor = UIColor(red: 0/255, green: 156/255, blue: 248/255, alpha: 1).cgColor
                    
                    view.layer.addSublayer(layer)
                    
                    if error != nil {
                        print("CANNOT AUTHORIZE")
                    }
                })
            }
            else {
                if error != nil {
                    print("CANNOT AUTHORIZE")
                }
            }
        })
        
        view.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        view.layer.masksToBounds = false
        self.stepBarVerticalStackView[days].insertArrangedSubview(view, at: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stepArray = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.stepArray = [Double]()
    }
    
}
