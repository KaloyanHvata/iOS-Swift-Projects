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
        
        let firstName = "Kaloyan"
        let lastName = "Petrov"
        let name = "\(firstName) \(lastName)"
        let theName = firstName + " " + lastName
        print(name , theName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

