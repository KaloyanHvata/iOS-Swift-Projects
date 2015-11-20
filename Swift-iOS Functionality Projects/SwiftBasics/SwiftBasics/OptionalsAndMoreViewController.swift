//
//  OptionalsAndMoreViewController.swift
//  SwiftBasics
//
//  Created by Kaloyan Petrov on 11/20/15.
//  Copyright © 2015 Kaloyan Petrov. All rights reserved.
//

import UIKit

class OptionalsAndMoreViewController: UIViewController {
    var states:NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //An optional is a variable taht may have a value or may have no value at all
        var temperature : Double?
        
        //Connect to the internet to get temp
        temperature = 25.5
        
        if temperature != nil {
            print("Temp is \(temperature)")
        }else{
            print("Could not be retrieved.")
        }
        
        //Sample of if let, and guard
       // var tempString = "The temperature is \(temperature)."
        
        if let temp = temperature{
            var tempString = "The temperature is \(temp)."
        }else{
            print("Temp not available.")
        }
        
        self.states = ["NJ" : "New Jersey", "NY" : "New York"]
        
        getStates("NY")
        getStates("CA")
        
        //ENUMERATIONS! (Limit selections and often used for user selection within applications)
        let keyboardType = UIKeyboardType.NumberPad
        let keyboardStyle = UIKeyboardAppearance.Dark
        
        //
        enum SeatPreference {
            
            case Window
            case Aisle
            case Middle
            case NoPreference
            
        }
        
        var customerPreferes : SeatPreference
        
        customerPreferes = SeatPreference.Window
        
        
        switch customerPreferes{
            
        case .Window:
                print("The customer prefers the window seat.")
        case .Aisle:
                print("The customer prefers the aisle seat.")
        case .Middle:
                print("The customer prefers the middle seat.")
        case .NoPreference:
                print("The customer ahe no preference of seating.")
            
        }
        
        
        //Error Handling with enumeration and switches
        
        enum LoginFailure : ErrorType{
            case InvalidUsername
            case InvalidPassword
        }
        
        let dbUsername = "user 1"
        let dbPassword = "pass 1"
        
        var loginError = LoginFailure.InvalidPassword
        //A small helper func inside viewDidLoad()
        ///////////////////////////////////////
        func loginUser(username: String, password: String) throws -> Bool{
            //check the db for username
            guard username == dbUsername else {
            
                loginError = LoginFailure.InvalidUsername
                throw LoginFailure.InvalidUsername
            }
            //check the db for the password
            guard password == dbPassword else{
            
                loginError = LoginFailure.InvalidPassword
                throw LoginFailure.InvalidPassword
            }
            return true
        }
        ////////////////////////////////////////
        do {
            try loginUser("user 1", password: "pass1")
            print("Login Successful")
        
        }catch {
        
            switch loginError{
            
            case .InvalidUsername:
                print("Invalid Username")
            case .InvalidPassword:
                print("Invalid Password")
            }
        
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARKL -Helper Methods
    
    func getStates(abbrev: String) -> String{
    
        guard let state = self.states![abbrev] else{
            return "State not found for\(abbrev)"
        }
        
        return "\(abbrev) is short for \(state)"
    }
    
}
