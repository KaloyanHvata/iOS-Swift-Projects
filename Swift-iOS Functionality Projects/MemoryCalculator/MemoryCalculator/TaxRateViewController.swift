//
//  TaxRateViewController.swift
//  MemoryCalculator
//
//  Created by Kaloyan Petrov on 11/25/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class TaxRateViewController: UIViewController {
    
    @IBOutlet weak var taxRateEntry: UITextField!
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyButtonPressed(sender: AnyObject) {
        
        if  taxRateEntry.text == "" {
            
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            defaults.setDouble(Double(taxRateEntry.text!)!, forKey: "taxrate")
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        
    }

 

}
