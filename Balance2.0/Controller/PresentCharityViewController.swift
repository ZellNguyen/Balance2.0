//
//  PresentCharityViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class PresentCharityViewController: UIViewController {
    
}

class PresentCharityPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "anualCharityTableViewController") as! AnualCharityTableViewController
        self.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        self.dataSource = self
        self.edgesForExtendedLayout = []
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let _ = viewController as? AnualCharityTableViewController {
            return nil
        }
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "anualCharityTableViewController") as! AnualCharityTableViewController
        return firstVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let _ = viewController as? HistoryCharityTableViewController {
            return nil
        }
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "historyCharityTableViewController") as! HistoryCharityTableViewController
        return secondVC
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0 
    }
}

// MARK: Table View for anual Report

class AnualCharityTableViewController: UITableViewController {
    var month: Int!
    var year: Int!
    
    var donatedCharities = CharityList.donated
    var donatedCharitiesThisYear = [Charity]()
    
    var overallAnualSteps: Int = 0
    var monthlyReport = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Detect current month 
        let calendar = Calendar.current
        self.month = calendar.component(.month, from: Date())
        self.year = calendar.component(.year, from: Date())
        
        // Filter charities which were donated this year
        donatedCharitiesThisYear = donatedCharities.filter({ (charity: Charity) in
            if charity.donatedDate != nil {
                let donatedYear = calendar.component(.year, from: charity.donatedDate!)
                return donatedYear == self.year
            }
            return false
        })
        
        // Find Overall Anual Steps
        for charity in donatedCharitiesThisYear {
            overallAnualSteps += charity.donatedSteps
        }
        
        // Fill monthly report array with 0 
        self.monthlyReport = [Int](repeating: 0, count: 12)
        generateMonthlyReport()
        
        // Dynamic height rows
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
    }
    
    func generateMonthlyReport() {
        for month in 1...12 {
            for charity in donatedCharitiesThisYear {
                if charity.donatedDate != nil {
                    let donatedMonth = Calendar.current.component(.month, from: charity.donatedDate!)
                    if donatedMonth == month {
                        monthlyReport[month-1] += charity.donatedSteps
                    }
                }
            }
        }
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return month + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "anualCell") as! AnualCharityReportCell
            cell.anualStepLabel.text = String(self.overallAnualSteps)
            let anualMoney = String(format: "%.2f", Float(overallAnualSteps)/10000)
            cell.anualMoneyLabel.text = "$\(anualMoney)"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyCell") as! MonthlyCharityReportCell
        let max = monthlyReport.max()! > 0 ? Float(monthlyReport.max()!/10000) : 0.01
        
        // Set labels for each cell
        switch month - indexPath.row + 1 {
        case 1:
            cell.monthLabel.text = "Jan."
            let money = String(format: "%.2f", Float(monthlyReport[0])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[0]/10000) / max + 0.01
            cell.progressView.progress = ratio
            
        case 2:
            cell.monthLabel.text = "Feb."
            let money = String(format: "%.2f", Float(monthlyReport[1])/10000)
            cell.moneyLabel.text = "$\(money)"

            let ratio = Float(monthlyReport[1]/10000) / max + 0.01
            cell.progressView.progress = ratio
            
        case 3:
            cell.monthLabel.text = "Mar."
            let money = String(format: "%.2f", Float(monthlyReport[2])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[2]/10000) / max + 0.01
            cell.progressView.progress = ratio

        case 4:
            cell.monthLabel.text = "Apr."
            let money = String(format: "%.2f", Float(monthlyReport[3])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[3]/10000) / max + 0.01
            cell.progressView.progress = ratio

        case 5:
            cell.monthLabel.text = "May."
            let money = String(format: "%.2f", Float(monthlyReport[4])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[4]/10000) / max + 0.01
            cell.progressView.progress = ratio

        case 6:
            cell.monthLabel.text = "Jun."
            let money = String(format: "%.2f", Float(monthlyReport[5])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[5]/10000) / max + 0.01
            cell.progressView.progress = ratio

        case 7:
            cell.monthLabel.text = "Jul."
            let money = String(format: "%.2f", Float(monthlyReport[6])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[6]/10000) / max + 0.01
            cell.progressView.progress = ratio

        case 8:
            cell.monthLabel.text = "Aug."
            let money = String(format: "%.2f", Float(monthlyReport[7])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[7]/10000) / max + 0.01
            cell.progressView.progress = ratio

        case 9:
            cell.monthLabel.text = "Sep."
            let money = String(format: "%.2f", Float(monthlyReport[8])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[8]/10000) / max + 0.01
            cell.progressView.progress = ratio

        case 10:
            cell.monthLabel.text = "Oct."
            let money = String(format: "%.2f", Float(monthlyReport[9])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[9]/10000) / max + 0.01
            cell.progressView.progress = ratio
            
        case 11:
            cell.monthLabel.text = "Nov."
            let money = String(format: "%.2f", Float(monthlyReport[10])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[10]/10000) / max + 0.01
            cell.progressView.progress = ratio

        case 12:
            cell.monthLabel.text = "Dec."
            let money = String(format: "%.2f", Float(monthlyReport[11])/10000)
            cell.moneyLabel.text = "$\(money)"
            
            let ratio = Float(monthlyReport[11]/10000) / max + 0.01
            cell.progressView.progress = ratio

        default:
            break
        }
        
        cell.progressView.transform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        
        return cell
    }
    
}

class AnualCharityReportCell: UITableViewCell {
    @IBOutlet var anualStepLabel: UILabel!
    @IBOutlet var anualMoneyLabel: UILabel!
}

class MonthlyCharityReportCell: UITableViewCell {
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var moneyLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
}

// MARK: Table View for single program report

class HistoryCharityTableViewController: UITableViewController {
    var donatedCharities = CharityList.donated
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donatedCharities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCharityCell") as! HistoryCharityCell
        
        let charity = donatedCharities[indexPath.row]
        
        cell.titleLabel.text = charity.title
        
        if charity.donatedDate != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let dateString = dateFormatter.string(from: charity.donatedDate!)
            cell.dateLabel.text = dateString + "  >"
        }
        else {
            cell.dateLabel.text = ""
        }
        
        cell.stepsLabel.text = String(charity.donatedSteps)
        
        let money = String(format: "%.2f", Float(charity.donatedSteps) / 10000)
        cell.moneyLabel.text = money
        
        return cell
    }
}

class HistoryCharityCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var stepsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var moneyLabel: UILabel!
    
}
