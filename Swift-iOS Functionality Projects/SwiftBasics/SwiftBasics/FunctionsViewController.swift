//
//  FunctionsViewController.swift
//  SwiftBasics
//
//  Created by Kaloyan Petrov on 11/10/15.
//  Copyright © 2015 Kaloyan Petrov. All rights reserved.
//

import UIKit
class FunctionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        printNumber(26)
        
        turnOffAppliance("oven", isOn: false)
        turnOffAppliance("television", isOn: true)
        
        multiply(26, num2: 21)
        
        //GUARD SYNTAX FUNCTION
        greeting(["name":"Kaloyan"]) //with names(plural) it wont work
        
        //ERROR THROWING
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK Helper Functions
    
    func printNumber(number: Int) -> String {
    
        return "The number given was \(number)."
    }

    func turnOffAppliance(appliance: String, isOn: Bool){
    
        if isOn == true {
            
            print("Please turn of the \(appliance)")
            
        }else{
        
            print("I have already turned off the \(appliance)")
        }
    
    }
    
    func multiply (num1: Int, num2: Int) -> String{
    
        let result = "\(num1 * num2)"
        return result
    }
    //GUARD SYNTAX
    func greeting(person: [String:String]){
    
        guard let name = person["name"] else{
            return
        }
        
    print("Hello there \(name)")
    
    }
    
    func withdrawl(amount: Double) throws -> Double{
        
        var bankBalance :Double = 1000
        var bankIsAvailable = true
        
        enum BankingError : ErrorType{
            case INsufficientFunds
            case BankNotAvailable
        }


    
        guard bankBalance > amount else{
            throw BankingError.INsufficientFunds
        }
        guard bankIsAvailable == true else{
        
            throw BankingError.BankNotAvailable
        }
        bankBalance = bankBalance - amount
        
        return bankBalance
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
