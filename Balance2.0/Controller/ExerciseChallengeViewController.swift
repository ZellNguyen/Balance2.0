//
//  ChallengeViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-16.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class ExerciseChallengeViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var categories: [String]! = ["Pending Challenges", "Active Challenges", "Past Challenges"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let startVC = self.viewController(atIndex: 0) as ExerciseChallengeTableViewController
        self.setViewControllers([startVC], direction: .forward, animated: false, completion: nil)
        self.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
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
    
    
    func viewController(atIndex index: Int) -> ExerciseChallengeTableViewController{
        if self.categories.count == 0 || index >= self.categories.count || index < 0 {
            return ExerciseChallengeTableViewController()
        }
        let vc: ExerciseChallengeTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChallengeListViewController") as! ExerciseChallengeTableViewController

        vc.category = categories[index]
        vc.pageIndex = index
        return vc
    }
    
    // MARK: Page View Controller Data Source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ExerciseChallengeTableViewController
        
        if vc.pageIndex == 0 || vc.pageIndex == NSNotFound {
            return nil
        }
        
        let previousVC = self.viewController(atIndex: vc.pageIndex - 1)
        return previousVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ExerciseChallengeTableViewController
        
        if vc.pageIndex >= self.categories.count - 1 || vc.pageIndex == NSNotFound {
            return nil
        }
        
        let nextVC = self.viewController(atIndex: vc.pageIndex + 1)
        return nextVC
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.categories.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

class ExerciseChallengeTableViewController: UITableViewController {
    
    var category: String!
    var challenges: ChallengeList?
    var pageIndex: Int!
    
    @IBOutlet var categoryLabel: UILabel!
    
    func filterChallenge(byStatus filterStatus: ChallengeStatus){
        self.challenges?.allChallenges = ChallengeList.exerciseChallengeList.allChallenges.filter({ (challenge: Challenge) -> Bool in
            let status = challenge.status
            return (status == filterStatus)
        })
    }
    
    func filterChallenge(byIndex index: Int){
        switch pageIndex {
        case 0:
            self.filterChallenge(byStatus: .pending)
        case 1:
            self.filterChallenge(byStatus: .active)
            challenges?.loadProgress()
        case 2:
            self.filterChallenge(byStatus: .finished)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.challenges = ChallengeList()
        
        self.filterChallenge(byIndex: pageIndex)
        
        self.categoryLabel.text = category
        
        self.tableView.reloadData()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.challenges = ChallengeList()
        self.filterChallenge(byIndex: pageIndex)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     // MARK: Challenge Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges!.allChallenges.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch pageIndex {
        case 0:
            let challenge = challenges?.allChallenges[indexPath.row] as! IndividualExerciseChallenge
            
            // In case the challenge is sent by user
            if challenge.sender == ProfileManager.myProfile.myself {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseChallengeSentCell")! as! ExerciseChallengeSentCell
                
                cell.receiverImage.image = challenge.receiver?.profile.picture ?? UIImage.init(named: "default-image-post")
                cell.receiverImage.layer.masksToBounds = true
                cell.receiverImage.layer.cornerRadius = CGFloat(21.5)
                
                cell.receiverNameLabel.text = challenge.receiver?.fullName
                cell.messageLabel.text = challenge.message
                let fromDateString = DateFormatter.localizedString(from: challenge.fromDate, dateStyle: .medium, timeStyle: .none)
                let toDateString = DateFormatter.localizedString(from: challenge.toDate, dateStyle: .medium, timeStyle: .none)
                
                cell.dateLabel.text = ("\(fromDateString) - \(toDateString)")
                return cell
            }
            
                
            // In case the challenge is received by user
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseChallengeReceivedCell")! as! ExerciseChallengeReceivedCell
                
                cell.senderImage.image = challenge.sender.profile.picture ?? UIImage.init(named: "default-image-post")
                cell.senderImage.layer.masksToBounds = true
                cell.senderImage.layer.cornerRadius = CGFloat(21.5)
                
                cell.senderNameLabel.text = challenge.sender.fullName
                cell.messageLabel.text = challenge.message
                let fromDateString = DateFormatter.localizedString(from: challenge.fromDate, dateStyle: .medium, timeStyle: .none)
                let toDateString = DateFormatter.localizedString(from: challenge.toDate, dateStyle: .medium, timeStyle: .none)
                
                cell.dateLabel.text = ("\(fromDateString) - \(toDateString)")
                cell.acceptButton.tag = indexPath.row
                cell.acceptButton.layer.cornerRadius = 9
                cell.ignoreButton.tag = indexPath.row
                cell.ignoreButton.layer.cornerRadius = 9
                cell.acceptButton.addTarget(self, action: #selector(acceptChallenge(_:)), for: .touchUpInside)
                cell.ignoreButton.addTarget(self, action: #selector(ignoreChallenge(_:)), for: .touchUpInside)
                
                return cell
            }
            
        case 1, 2:
            let challenge = challenges?.allChallenges[indexPath.row] as! IndividualExerciseChallenge
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseActiveChallengeCell") as! ExerciseActiveChallengeCell
            if challenge.sender == ProfileManager.myProfile.myself {
                cell.friendNameLabel.text = challenge.receiver?.fullName
                cell.friendImage.image = challenge.receiver?.profile.picture
                cell.userImage.image = challenge.sender.profile.picture
            }
            else {
                cell.friendNameLabel.text = challenge.sender.fullName
                cell.friendImage.image = challenge.sender.profile.picture
                cell.userImage.image = challenge.receiver?.profile.picture
            }
            cell.friendImage.layer.masksToBounds = true
            cell.friendImage.layer.cornerRadius = CGFloat(12)
            cell.userImage.layer.masksToBounds = true
            cell.userImage.layer.cornerRadius = CGFloat(12)
            cell.userStepBar.progress = Float(challenge.myCurrentSteps)/50000 + 0.01
            cell.userStepBar.transform = CGAffineTransform(scaleX: 1.0, y: 7)
            cell.friendStepBar.progress = Float(challenge.friendCurrentSteps)/50000 + 0.01
            cell.friendStepBar.transform = CGAffineTransform(scaleX: 1.0, y: 7)
            
            let fromDateString = DateFormatter.localizedString(from: challenge.fromDate, dateStyle: .medium, timeStyle: .none)
            let toDateString = DateFormatter.localizedString(from: challenge.toDate, dateStyle: .medium, timeStyle: .none)
            
            cell.dateLabel.text = ("\(fromDateString) - \(toDateString)")
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func acceptChallenge(_ sender: UIButton){
        let challenge = self.challenges?.allChallenges[sender.tag]
        challenge?.status = ChallengeStatus.active
        self.filterChallenge(byIndex: pageIndex)
        self.tableView.reloadData()
    }
    
    func ignoreChallenge(_ sender: UIButton){
        let challenge = self.challenges?.allChallenges[sender.tag]
        challenge?.status = ChallengeStatus.expired
        self.filterChallenge(byIndex: pageIndex)
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.challenges = nil
    }
}

class ExerciseChallengeSentCell: UITableViewCell {
    @IBOutlet var receiverImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var receiverNameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
}

class ExerciseChallengeReceivedCell: UITableViewCell {
    @IBOutlet var senderImage: UIImageView!
    @IBOutlet var senderNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var ignoreButton: UIButton!
    @IBOutlet var acceptButton: UIButton!
   
}

class ExerciseActiveChallengeCell: UITableViewCell {
    @IBOutlet var friendImage: UIImageView!
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var friendStepBar: UIProgressView!
    @IBOutlet var userStepBar: UIProgressView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var friendNameLabel: UILabel!
}

class ParentExerciseChallengeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
