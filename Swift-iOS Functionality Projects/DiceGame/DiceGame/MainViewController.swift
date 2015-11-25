//
//  MainViewController.swift
//  DiceGame
//
//  Created by Kaloyan Petrov on 11/24/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController,AVAudioPlayerDelegate {
    //Audio Player
    var audioPlayer = AVAudioPlayer()
    //NSUserDefaults
    var defaults = NSUserDefaults.standardUserDefaults()
    //IBOutlets
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var leftDice: UIImageView!
    @IBOutlet weak var rightDice: UIImageView!
    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var steper: UIStepper!
    @IBOutlet weak var chipImageView: UIImageView!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var rollToPointButton: UIButton!
    @IBOutlet weak var addChipsButton: UIButton!
    @IBOutlet weak var betLabel: UILabel!
    //Tracking variables
    var currentChipBalance : Int?
    var currentBet : Int! = 250
    var total = Int! ()
    var total2 = Int! ()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - IBACtions
    
    @IBAction func addChipsButtonPressed(sender: AnyObject) {
        
        defaults.setObject(10000, forKey: "currentChipBalance")
        balanceLabel.text = defaults.stringForKey("currentChipBalance")
        currentChipBalance = Int(defaults.stringForKey("currentChipBalance")!)
        defaults.synchronize()
        addChipsButton.hidden = true
        statusLabel.hidden = true
        
        rollButton.hidden = false
        //play sound
        do{
            try playSound("tapped", fileExtension: "mp3")
        }catch{
            print("Can't play tapped sound")
            return
        }
    }
 
    @IBAction func startNewGameButtonsPressed(sender: AnyObject) {
        //reset visibility
        resultLabel.hidden = true
        statusLabel.hidden = true
        leftDice.image = UIImage(named: "dice06")
        rightDice.image = UIImage(named: "dice06")
        rollButton.hidden = false
        rollToPointButton.hidden = true
        startNewGameButton.hidden = true
        //play sound
        do{
            try playSound("tapped", fileExtension: "mp3")
        }catch{
            print("Can't play tapped sound")
            return
        }
    }
   
    @IBAction func stepperChanged(sender: UIStepper) {
        
        //play sound
        do{
            try playSound("tapped", fileExtension: "mp3")
        }catch{
            print("Can't play tapped sound")
            return
        }
        //Set the bet text and chip image to match stepper value
        betLabel.text = Int(steper.value).description
        currentBet = Int(steper.value)
        //Change images based on steper value
        
        switch steper.value{
        case 50:
            chipImageView.image = UIImage(named: "chip01")
        case 100:
            chipImageView.image = UIImage(named: "chip02")
        case 150:
            chipImageView.image = UIImage(named: "chip03")
        case 200:
            chipImageView.image = UIImage(named: "chip04")
        case 250:
            chipImageView.image = UIImage(named: "chip05")
            default:
                break
        
        }
    }
    
    @IBAction func rollButtonPressed(sender: AnyObject) {
        if self.currentChipBalance == nil || self.currentChipBalance < 250 {
        
            addChipsButton.hidden = false
            statusLabel.hidden = false
            statusLabel.text = "You need more chips to play. Press the red chip in the top right!"
            rollButton.hidden = true
            rollToPointButton.hidden = true
        }else{
            //play sound
            do{
                try playSound("roll", fileExtension: "mp3")
            }catch{
                print("Can't play roll sound")
                return
            }
                total = rollDiceForValue()
            //Evaluate the results
            switch total{
                case 2,3,12:
                    resultLabel.hidden = false
                    resultLabel.text = "YOU LOSE"
                    resultLabel.textColor = UIColor.redColor()
                    statusLabel.hidden = false
                    statusLabel.text = "You rollerd a \(total), and this is Crabs!"
                    rollButton.hidden = false
                    startNewGameButton.hidden = false
                    //play lose sound
                    do{
                        try playSound("lose", fileExtension: "mp3")
                    }catch{
                        print("Unable to play lose sound")
                        return
                    }
    
                    currentChipBalance = currentChipBalance! - currentBet!
                    defaults.setObject(currentChipBalance, forKey: "currentChipBalance")
                    balanceLabel.text = defaults.stringForKey("currentChipBalance")
                    defaults.synchronize()
                
                case 7,11:
                    resultLabel.hidden = false
                    resultLabel.text = "YOU WIN"
                    resultLabel.textColor = UIColor.greenColor()
                    statusLabel.hidden = false
                    statusLabel.text = "You rollerd a natural \(total), and this is a win in Crabs!"
                    rollButton.hidden = false
                    startNewGameButton.hidden = false
                    //play win sound
                    do{
                        try playSound("win", fileExtension: "mp3")
                    }catch{
                        print("Unable to play win sound")
                        return
                    }
                    currentChipBalance = currentChipBalance! + (currentBet!*2)
                    defaults.setObject(currentChipBalance, forKey: "currentChipBalance")
                    balanceLabel.text = defaults.stringForKey("currentChipBalance")
                    defaults.synchronize()
                
                case 4, 5, 6, 8, 9, 10:
                    resultLabel.hidden = false
                    resultLabel.text = "THAT'S POINT!!!"
                    statusLabel.hidden = false
                    statusLabel.text = "You rolled a \(total). Now you must roll another \(total) before rolling a 7 to win!"
                    rollButton.hidden = true
                
                // show the to point button / phase two of game
                
                    rollToPointButton.hidden = false
                
                    do {
                        try playSound("tapped", fileExtension: "mp3")
                    } catch {
                        return
                    }
                
                    currentChipBalance = currentChipBalance! - currentBet!
                    defaults.setObject(currentChipBalance, forKey: "currentChipBalance")
                    balanceLabel.text = defaults.stringForKey("currentChipBalance")
                    defaults.synchronize()
                
                default:
                    break
            }
        }
    }
    
    @IBAction func rollToPointButtonPressed(sender: AnyObject) {
        
        if currentChipBalance == nil || currentChipBalance < 250{
            
            addChipsButton.hidden = false
            statusLabel.hidden = false
            statusLabel.text = "You need more chips to play. Press the red chip in the top right!"
            rollButton.hidden = true
            rollToPointButton.hidden = true
        
        }else{
            //get point totals and set images
            total2 = rollDiceForValue()
            let pointToMatch = self.total
            
            switch total2 {
            
                case pointToMatch:
                    resultLabel.hidden = false
                    resultLabel.text = "YOU WIN"
                    resultLabel.textColor = UIColor.greenColor()
                    statusLabel.hidden = false
                    statusLabel.text = "You rolled a matching \(pointToMatch) for the win!"
                    rollToPointButton.hidden = true
                    startNewGameButton.hidden = false
                    //play win sound
                    do{
                        try playSound("win", fileExtension: "mp3")
                    }catch{
                        print("Unable to play win sound")
                        return
                    }
                    currentChipBalance = currentChipBalance! + (currentBet!*2)
                    defaults.setObject(currentChipBalance, forKey: "currentChipBalance")
                    balanceLabel.text = defaults.stringForKey("currentChipBalance")
                    defaults.synchronize()
            case 7:
                
                resultLabel.hidden = false
                resultLabel.text = "YOU LOSE!"
                resultLabel.textColor = UIColor.redColor()
                statusLabel.hidden = false
                statusLabel.text = "You landed on a 7 before rolling the match point \(pointToMatch). You lose!"
                rollToPointButton.hidden = true
                startNewGameButton.hidden = false
                do {
                    try playSound("lose", fileExtension: "mp3")
                } catch {
                    return
                }
                
                let defaults = self.defaults
                currentChipBalance = currentChipBalance! - currentBet!
                defaults.setObject(currentChipBalance, forKey: "currentChipBalance")
                balanceLabel.text = defaults.stringForKey("currentChipBalance")
                defaults.synchronize()
                
            default:
                
                resultLabel.hidden = false
                resultLabel.text = "Keep Rolling!"
                resultLabel.textColor = UIColor.grayColor()
                statusLabel.hidden = false
                statusLabel.text = "Win by rolling a \(pointToMatch) before rolling a losing 7."
                do {
                    try playSound("tapped", fileExtension: "mp3")
                } catch {
                    return
                }
                
                let defaults = self.defaults
                currentChipBalance = currentChipBalance! - currentBet!
                defaults.setObject(currentChipBalance, forKey: "currentChipBalance")
                balanceLabel.text = defaults.stringForKey("currentChipBalance")
                defaults.synchronize()

                }
        }
    }
    
    
    //MARK: - Helper Methods
    func rollDiceForValue() -> Int{
        var lDiceValue = Int(arc4random_uniform(UInt32(6)))
        var rDiceValue = Int(arc4random_uniform(UInt32(6)))
        var total = lDiceValue + rDiceValue + 2
        //First way to do it
        switch lDiceValue{
            case 0:
                leftDice.image = UIImage(named: "dice01")
                lDiceValue++
            case 1:
                leftDice.image = UIImage(named: "dice02")
                lDiceValue++
            case 2:
                leftDice.image = UIImage(named: "dice03")
                lDiceValue++
            case 3:
                leftDice.image = UIImage(named: "dice04")
                lDiceValue++
            case 4:
                leftDice.image = UIImage(named: "dice05")
                lDiceValue++
            case 5:
                leftDice.image = UIImage(named: "dice06")
                lDiceValue++
            default:
                    break
        }
        
        //Second way to do it with some refactoring
        switch rDiceValue {
            case 0...5:
                rightDice.image = UIImage(named: "dice0\(rDiceValue+1)")
                rDiceValue++
            default:
                break
        }
        
        return total
    }
    
    
    func playSound(fileName: String, fileExtension: String) throws {
        
        let dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(dispatchQueue, { let mainBundle = NSBundle.mainBundle()
            
            let filePath = mainBundle.pathForResource("\(fileName)", ofType:"\(fileExtension)")
            
            if let path = filePath{
                let fileData = NSData(contentsOfFile: path)
                
                do {
                    /* Start the audio player */
                    self.audioPlayer = try AVAudioPlayer(data: fileData!)
                    
                    guard let player : AVAudioPlayer? = self.audioPlayer else {
                        return
                    }
                    
                    /* Set the delegate and start playing */
                    player!.delegate = self
                    if player!.prepareToPlay() && player!.play() {
                        /* Successfully started playing */
                    } else {
                        /* Failed to play */
                    }
                    
                } catch {
                    //self.audioPlayer = nil
                    return
                }
                
            }
            
        })
        
    }
    
}



