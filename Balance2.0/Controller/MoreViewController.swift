//
//  MoveViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-13.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        performSegue(withIdentifier: "ShowLogIn", sender: self)
    }
    
    @IBOutlet var stepLabel: UILabel!
    
    override func viewDidLoad() {
        stepLabel.text = String(StepCounter.main.steps )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stepLabel.text = String(StepCounter.main.steps )
    }
    
}
