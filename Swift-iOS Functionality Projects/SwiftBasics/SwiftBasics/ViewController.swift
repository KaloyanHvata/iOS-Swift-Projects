//
//  ViewController.swift
//  SwiftBasics
//
//  Created by Kaloyan Petrov on 11/5/15.
//  Copyright © 2015 Kaloyan Petrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Interpolation and concatenation in Swift
        let firstName = "Kaloyan"
        let lastName = "Petrov"
        let name = "\(firstName) \(lastName)"
        let theName = firstName + " " + lastName
        print(name , theName)
        
        
        
        //Control flow - Swift's ternary operator
        var temp = 23
        var isFreezing : Bool
        
        if temp <= 32 {
            isFreezing = true
        } else {
            isFreezing = false
        }
        //Simple syntax but worse readability
        isFreezing = temp <= 32 ? true : false
        //Setting a value
        var statement : String = isFreezing == true ? "It's Freezing" : "It's not Freezing"
        
        
        
        //Basic for and for/in loops in Swift
        for var i = 1; i <= 10; i++ {
            print("i = \(i).")
        }
        //For/in
        let names = ["Koko","Bob","Petya","Lora"]
        for name in names {
            print(name)
        }
        let inventory = [1: "television",2: "radio",3: "computer",4: "smartphone"]
        //Tuple Example
        for (key, value) in inventory{
            print("\(key):\(value)")
        }
        
        //Do/While or in Swift a repeat/while loop
        var x = 1
        repeat {
            print(x)
            x++
        } while x <= 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

