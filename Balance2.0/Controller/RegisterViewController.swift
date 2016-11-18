//
//  RegisterViewController.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-13.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var repeatPasswordTextField: UITextField!
    @IBOutlet var fullNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        fullNameTextField.delegate = self
    }
    
    @IBAction func register(_ sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        let fullName = fullNameTextField.text
        
        if let email = email, let password = password, let repeatPassword = repeatPassword, let fullName = fullName, email.isEmpty || fullName.isEmpty || password.isEmpty || repeatPassword.isEmpty {
            
            // Display alert message
            display(alert: "All fields are required!")
            return
        }
        
        // Match passwords
        if password != repeatPassword {
            display(alert: "Passwords do not match")
            return
        }
        
        // Create User Profile Management
        ProfileManager.myProfile.register(email: email!, fullName: fullName!)
        let friendList = ProfileManager.myProfile.friendList
        let friendListData = NSKeyedArchiver.archivedData(withRootObject: friendList!)
        let profile = ProfileManager.myProfile.profile
        let profileData = NSKeyedArchiver.archivedData(withRootObject: profile!)
        
        // Set User 
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(password, forKey: "userPassword")
        UserDefaults.standard.set(fullName, forKey: "userFullName")
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        UserDefaults.standard.set(friendListData, forKey: "userFriendList")
        UserDefaults.standard.set(profileData, forKey: "userProfile")
        UserDefaults.standard.synchronize()
        
        // Display confirmation 
        let confirmAlert = UIAlertController(title: "Confirmation", message: "Your account has been created", preferredStyle: .alert)
    
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.performSegue(withIdentifier: "ShowProfileView", sender: self)
        })
        
        confirmAlert.addAction(okAction)
        present(confirmAlert, animated: true, completion: nil)
        
    }
    
    func display(alert message: String) {
        let myAlert = UIAlertController(title:"Alert", message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func dismissKeyboard(){
        if emailTextField.isEditing {
            emailTextField.resignFirstResponder()
        }
        if fullNameTextField.isEditing {
            fullNameTextField.resignFirstResponder()
        }
        if passwordTextField.isEditing {
            passwordTextField.resignFirstResponder()
        }
        if repeatPasswordTextField.isEditing {
            repeatPasswordTextField.resignFirstResponder()
        }
    }
    
    // User has an account, cancel resgistration
    @IBAction func cancelRegister(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
