//
//  MainViewController.swift
//  TipCalculator
//
//  Created by Kaloyan Petrov on 11/24/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITextFieldDelegate {
    //IBOutlets
    @IBOutlet weak var subtotalTextView: UITextField!
    @IBOutlet weak var percentFromSlider: UISlider!
    @IBOutlet weak var showPercentLabel: UILabel!
    @IBOutlet weak var numberOfPeopleTextField: UITextField!
    @IBOutlet weak var tipPerPersonLabel: UILabel!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var startOverButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        subtotalTextView.delegate = self
        numberOfPeopleTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: -IBActions
    @IBAction func sliderChanged(sender: UISlider) {
        //set value of slider
        let currentValue = Int(percentFromSlider.value)
        
        //update text with value
        showPercentLabel.text = "\(currentValue)%"
        
        
    }
    @IBAction func calculateTipButtonPressed(sender: AnyObject) {
        //Check if populated
        if subtotalTextView.text == nil{
            subtotalTextView.text = "0.00"
        }
        if numberOfPeopleTextField.text == nil{
            numberOfPeopleTextField.text = "1"
        }
        let subTotal = Float(subtotalTextView.text!)
        let split = Float(numberOfPeopleTextField.text!)
        let percentage = Int(percentFromSlider.value)
        
        //perform calculation
        tipPerPersonLabel.text = "$" + String(subTotal! * (Float(percentage)/100)/split!)
        //Unhide what we need
        tipPerPersonLabel.hidden = false
        perPersonLabel.hidden = false
        startOverButton.hidden = false
        showPercentLabel.hidden = false
        
        //resign keyboards
        subtotalTextView.resignFirstResponder()
        numberOfPeopleTextField.resignFirstResponder()
    }

    @IBAction func startOverButtonPressed(sender: AnyObject) {
        
        tipPerPersonLabel.hidden = true
        perPersonLabel.hidden = true
        startOverButton.hidden = true
        subtotalTextView.text = nil
        numberOfPeopleTextField.text = nil
        percentFromSlider.value = 20
        tipPerPersonLabel.text = nil
        showPercentLabel.text = "20%"
    }
    
    //MARK: - Delegates
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        subtotalTextView.resignFirstResponder()
        numberOfPeopleTextField.resignFirstResponder()
    }
    
}
