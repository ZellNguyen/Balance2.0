//
//  LogInViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-13.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.dismissKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
    
    func dismissKeyboard(){
        if emailTextField.isEditing {
            emailTextField.resignFirstResponder()
        }
        if passwordTextField.isEditing {
            passwordTextField.resignFirstResponder()
        }
    }
    
    func verifyAccount() -> Bool {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        let emailStore = UserDefaults.standard.string(forKey: "userEmail")
        let passwordStore = UserDefaults.standard.string(forKey: "userPassword")
        
        if email == emailStore && password == passwordStore {
            return true
        }
        else {
            return false
        }
    }
    
    @IBAction func login(_ sender: Any) {

        if self.verifyAccount() == true {
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
            
            // Store data for profile manager object
            let email = UserDefaults.standard.string(forKey: "userEmail")
            let fullName = UserDefaults.standard.string(forKey: "userFullName")
            let friendListData = UserDefaults.standard.data(forKey: "userFriendList")
            let friendList = NSKeyedUnarchiver.unarchiveObject(with: friendListData!) as! FriendList
            
            let profileData = UserDefaults.standard.data(forKey: "userProfile")
            let profile = NSKeyedUnarchiver.unarchiveObject(with: profileData!) as! UserProfile
            
            
            ProfileManager.myProfile.login(email: email!, fullName: fullName!, friendList: friendList, profile: profile)
            
            self.performSegue(withIdentifier: "ShowHome", sender: self)
        }
        else {
            showErrorLoginAlert()
        }
    }
    
    func showErrorLoginAlert() {
        let errorAlert = UIAlertController(title: "Login Failed", message: "Incorrect email or password!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        errorAlert.addAction(okAction)
        
        self.present(errorAlert, animated: true, completion: nil)
    }
}
