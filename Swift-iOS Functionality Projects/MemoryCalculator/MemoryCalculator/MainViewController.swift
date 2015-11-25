//
//  MainViewController.swift
//  MemoryCalculator
//
//  Created by Kaloyan Petrov on 11/25/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //reference -> + − × ÷ √ % ⚙

    @IBOutlet weak var displayLabel: UILabel!
    //Seting up getters and setters to the displayValue
    var displayValue : Double {
        get{
            return Double(displayLabel.text!)!
        }
        set{
            displayLabel.text = "\(newValue)"
        }
    }
    //Other variables
    var userIsTypingNumber = false
    var numberOne : Double = 0
    var numberTwo : Double = 0
    var currentOperator = ""
    let defaults = NSUserDefaults.standardUserDefaults()
    var saveNumber : Double = 0
    var memoryType = ""
    var tax : Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func digitButtonPressed(sender: UIButton) {
        
        let digit = sender.currentTitle
        
        if userIsTypingNumber == false{
        
            displayLabel.text = ""
            displayLabel.text = digit
            userIsTypingNumber = true

        }else if userIsTypingNumber == true {
        
            displayLabel.text = displayLabel.text! + digit!
        
        }
        
    }

    @IBAction func operatorButtonPressed(sender: UIButton) {
        
            userIsTypingNumber = false
            currentOperator = sender.currentTitle!
        
        if numberOne == 0 && numberTwo == 0 {
        
            switch currentOperator {
                case "÷":
                currentOperator = "/"
                numberOne = displayValue
                case "×":
                currentOperator = "*"
                numberOne = displayValue
                case "−":
                currentOperator = "-"
                numberOne = displayValue
                case "+":
                currentOperator = "+"
                numberOne = displayValue
                
            default:
                break
            
            }
        
        }else if numberOne != 0 && numberTwo == 0{
        
            switch currentOperator {
            case "÷":
                currentOperator = "/"
                numberTwo = displayValue
                displayValue = numberOne / numberTwo
                numberOne = displayValue
                numberTwo = 0
            case "×":
                currentOperator = "*"
                numberTwo = displayValue
                displayValue = numberOne * numberTwo
                numberOne = displayValue
                numberTwo = 0
               
            case "−":
                currentOperator = "-"
                numberTwo = displayValue
                displayValue = numberOne - numberTwo
                numberOne = displayValue
                numberTwo = 0
              
            case "+":
                currentOperator = "+"
                numberTwo = displayValue
                displayValue = numberOne + numberTwo
                numberOne = displayValue
                numberTwo = 0
                
            default:
                break
                
            }

        
        }
        
    }
    
    @IBAction func equalButtonPressed(sender: AnyObject) {
        
        userIsTypingNumber = false
        numberTwo = displayValue

        if currentOperator == "/"{
            
            displayValue = numberOne / numberTwo
            
        }else if currentOperator == "*"{
        
            displayValue = numberOne * numberTwo
            
        }else if currentOperator == "-"{
            
            displayValue = numberOne - numberTwo
            
        }else if currentOperator == "+"{
            
            displayValue = numberOne + numberTwo
        }
        numberOne = displayValue
        
    }
    
    @IBAction func minusTenPercentButtonPressed(sender: AnyObject) {
        
        userIsTypingNumber = false
        displayValue = displayValue * (90/100)
        
    }
    
    @IBAction func plusTaxButtonPressed(sender: AnyObject) {
        
        userIsTypingNumber = false
        tax = defaults.doubleForKey("taxrate")
        displayValue = (displayValue + (displayValue * (tax / 100)))
        
        
    }
    
    @IBAction func memoryButtonPressed(sender: UIButton) {
        
        
            memoryType = sender.currentTitle!
        
        switch memoryType{
        
            case "M+":
                saveNumber = saveNumber + displayValue
                defaults.setDouble(saveNumber, forKey: "saved")
            case "M-":
                saveNumber = saveNumber - displayValue
                defaults.setDouble(saveNumber, forKey: "saved")
            case "MR":
              displayValue = defaults.doubleForKey("saved")
            
            case "MR":
                defaults.removeObjectForKey("saved")
                displayLabel.text = "0"
            case "CA":
                defaults.removeObjectForKey("saved")
                clearButtonPressed(self)
            default:
                break
            

        }
        
    }
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        
        currentOperator = ""
        numberTwo = 0
        numberOne = 0
        displayValue = 0
        displayLabel.text = "0"
        userIsTypingNumber = false
        
        
    }
    
    @IBAction func sqrtButtonPressed(sender: AnyObject) {
        
        displayValue = sqrt(displayValue)
        
    }
   
    @IBAction func percentButtonPressed(sender: AnyObject) {
        
        numberTwo = displayValue
        if currentOperator == "+" || currentOperator == "-" {
        
            displayValue = (numberTwo / 100) * numberOne
        
        }else if currentOperator == "/" || currentOperator == "*"{
            
            displayValue = (numberTwo / 100)
        
        }
        
        
        
        
    }
    
    
}

















