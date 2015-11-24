//
//  MainViewController.swift
//  UserDefaults
//
//  Created by Kaloyan Petrov on 11/24/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITextFieldDelegate {
    //Text Fields
    @IBOutlet weak var firstNameEntryTextField: UITextField!
    @IBOutlet weak var lastNameEntryTextField: UITextField!
    @IBOutlet weak var cityEntryTextField: UITextField!
    //Labels
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    //Defaults variable
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set defaults just in case if we are with nested state
        let defaults = self.defaults
        
        //load saved data
        if let fname = defaults.stringForKey("savedfirstname"){
            firstNameLabel.text = fname
        }
        if let lname = defaults.stringForKey("savedlastname"){
            lastNameLabel.text = lname
        }
        if let city = defaults.stringForKey("savedcity"){
            cityLabel.text = city
        }

        //Set Keyboard delegates
        firstNameEntryTextField.delegate = self
        lastNameEntryTextField.delegate = self
        cityEntryTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveAndDisplayButtonPressed(sender: AnyObject) {
        //Save our data
        defaults.setObject(firstNameEntryTextField.text, forKey: "savedfirstname")
        defaults.setObject(lastNameEntryTextField.text, forKey: "savedlastname")
        defaults.setObject(cityEntryTextField.text, forKey: "savedcity")
        //synchronizing
        defaults.synchronize()
        //displaying the saved data
        if let fname = defaults.stringForKey("savedfirstname"){
            firstNameLabel.text = fname
        }
        if let lname = defaults.stringForKey("savedlastname"){
            lastNameLabel.text = lname
        }
        if let city = defaults.stringForKey("savedcity"){
            cityLabel.text = city
        }
        //clear textfield contents
        firstNameEntryTextField.text = ""
        lastNameEntryTextField.text = ""
        cityEntryTextField.text = ""
        
        //dissmiss keyboard
        firstNameEntryTextField.resignFirstResponder()
        lastNameEntryTextField.resignFirstResponder()
        cityEntryTextField.resignFirstResponder()
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    //To dissmiss keyboard when touch outside of textfields
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        firstNameEntryTextField.resignFirstResponder()
        lastNameEntryTextField.resignFirstResponder()
        cityEntryTextField.resignFirstResponder()
    }
}
