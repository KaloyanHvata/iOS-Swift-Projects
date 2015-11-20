//
//  PropertyObserversViewController.swift
//  SwiftBasics
//
//  Created by Kaloyan Petrov on 11/20/15.
//  Copyright © 2015 Kaloyan Petrov. All rights reserved.
//

import UIKit

class PropertyObserversViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Example 1
        var inches : Double = 0
        
        var feet : Double {
            
            get {
                return(inches / 12)
            }
            set {
                inches = (newValue * 12)
            }
        }
        feet = 2
        
        print("Inches = \(inches)")
        print("Feet = \(feet)")
        
        //Example 2
        
        var celsius : Double = 0
        
        var fahrenheit : Double {
            get{
                return(celsius * 1.8) + 32
            }
            set{
                celsius = (newValue - 32)/1.8
            }
        }
        
        print("Celsius = \(celsius)")
        print("Fahrenheit = \(fahrenheit)")
        
        //
        var display = "0"
        
        var displayValue : Double {
            get{
                return Double(display)!
            }
            set{
                display = String(newValue)
            }
        
        }
        displayValue = 234
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
