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
    var challenges: ChallengeList! = ChallengeList()
    var pageIndex: Int!
    
    @IBOutlet var categoryLabel: UILabel!
    
    func filterChallenge(byStatus filterStatus: ChallengeStatus){
        self.challenges.allChallenges = ChallengeList.exerciseChallengeList.allChallenges.filter({ (challenge: Challenge) -> Bool in
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
        case 2:
            self.filterChallenge(byStatus: .finished)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterChallenge(byIndex: pageIndex)
        
        self.categoryLabel.text = category
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.filterChallenge(byIndex: pageIndex)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     // MARK: Challenge Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.allChallenges.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challengeCell")! as UITableViewCell
        
        let challenge = challenges.allChallenges[indexPath.row]
        
        cell.textLabel?.text = challenge.title
        cell.detailTextLabel?.text = challenge.receiver?.fullName
    
        return cell
    }
    
}
