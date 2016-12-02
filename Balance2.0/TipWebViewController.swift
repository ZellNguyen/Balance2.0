//
//  TipWebViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-12-02.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class TipWebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBOutlet var webView: UIWebView!
    var link: String? = nil
}
