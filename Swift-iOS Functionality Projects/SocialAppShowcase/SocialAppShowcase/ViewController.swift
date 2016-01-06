//
//  ViewController.swift
//  SocialAppShowcase
//
//  Created by Kaloyan Petrov on 12/28/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
        
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }
    
    //MARK: - IBActions
    @IBAction func fbButtonPressed(sender: UIButton){
    
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil {
            
                print ("Facebook login failed. Error \(facebookError)")
                
            }else{
            
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully loged in with Access Token: \(accessToken)")
            
                DataService.dataService.REF_BASE.authWithOAuthProvider("facebook",  token: accessToken, withCompletionBlock: { error, authData in
                
                    if error != nil {
                    
                        print("Login failed. \(error)")
                        
                    }else{
                        
                        print ("Logged in!\(authData)")
                        //Firebase
                        let user = ["provider": authData.provider!, "Test": "test"] // up for optimisation, if let statement and error handling
                        DataService.dataService.createFirebaseUser(authData.uid, user: user)
                        
                        
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                        //Store what type of account this is
                                         }
                    
                })
            }
        }
    }
    
    
    @IBAction func attemtptLoginEmail(sender:UIButton!){
    
        
        //Make sure there is an email and a password
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            DataService.dataService.REF_BASE.authUser(email, password: pwd) { error, authData in
                
                if error != nil {
                    print(error.code)
                    
                    if error.code == STATUS_ACCOUNT_NONEXIST {
                        DataService.dataService.REF_BASE.createUser(email, password: pwd,
                            withValueCompletionBlock: { error, result in
                                
                                if error != nil {
                                    
                                    self.showErrorAlert("Could not create account", msg: "Problem creating account. Try something else")
                                    
                                } else {
                                    
                                    
                                    
                                    NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                    
                                    DataService.dataService.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
                                    
                                    //Firebase
                                    //Completion Block
                                    DataService.dataService.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { err , authData in
                                        let user = ["provider": authData.provider!, "Test": "emailTest"] // up for optimisation, if let statement and error handling
                                        DataService.dataService.createFirebaseUser(authData.uid, user: user)
                                    
                                    })
                                    
                                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                                }
                        })
                    } else {
                        self.showErrorAlert("Could not log in.", msg: " Check your username and password")
                    }
                    
                } else {
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
                }
            }
        } else {
            showErrorAlert("Email & Password Required", msg: "You must enter an email address and a password")
        }
    }
    
    //MARK:- Helper func's
    func showErrorAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    
    }
}















