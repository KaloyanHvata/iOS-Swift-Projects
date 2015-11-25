//
//  ViewController.swift
//  Magic8Ball
//
//  Created by Kaloyan Petrov on 11/11/15.
//  Copyright © 2015 Kaloyan Petrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model : ModelAnswerBall = ModelAnswerBall()
    
    @IBOutlet weak var infoLabel: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        infoLabel.text = "Ask a Question!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getAnswerButtonPressed(sender: AnyObject) {
        
        //Get a random number
        let random = Int(arc4random_uniform(UInt32 (model.answers.count)))
        
        //Dispalay the answer
        infoLabel.text = model.answers[random]
        
        //Play the sound
        do {
            try model.playSound("shakesound", fileExtension: "wav")
        }catch{
            
            print("Error")
            return
        }
        
        //Adding a shake function
       
        
    }
    //MARK: Helper Methods
    
    override func  motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
    
     getAnswerButtonPressed(self)
        
    }
    
    
}

