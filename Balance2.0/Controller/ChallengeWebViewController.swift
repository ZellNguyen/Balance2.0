//
//  ViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-25.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class ChallengeWebViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var webView: UIWebView!
    @IBOutlet var completeButton: UIButton!
    var link: String? = "google.ca"
    var challenge: IndividualMealChallenge? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView.loadRequest(URLRequest(url: URL(string: link!)!))
        
        completeButton.layer.shadowColor = UIColor.black.cgColor
        completeButton.layer.shadowOpacity = 0.5
        completeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        //cell.parentView.layer.shadowPath = UIBezierPath(rect: CGRect(x: cell.parentView.bounds.minX, y: cell.parentView.bounds.minY, width: cell.parentView.bounds.width, height: cell.parentView.bounds.height + 4)).cgPath
        completeButton.layer.shadowRadius = 4
        completeButton.layer.shouldRasterize = true
        completeButton.layer.rasterizationScale = UIScreen.main.scale
        
        //completeButton.layer.masksToBounds = true
        completeButton.layer.cornerRadius = CGFloat(20)
        
        self.automaticallyAdjustsScrollViewInsets = false
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

    @IBAction func takePhoto(_ sender: UIButton) {
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
            viewController.isChallenge = true
            viewController.challenge = self.challenge
            viewController.image = image
            if let navigator = self.navigationController {
                var controllers = navigator.viewControllers
                let index = controllers.index(of: self)
                controllers[index!] = viewController
                navigator.setViewControllers(controllers, animated: true)
            }
        }
    }
    
}
