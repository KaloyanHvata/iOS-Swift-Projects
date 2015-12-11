//
//  MainViewController.swift
//  RPG-OOP
//
//  Created by Kaloyan Petrov on 12/10/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var printLabel: UILabel!
    @IBOutlet weak var playerHpLabel: UILabel!
    @IBOutlet weak var enemyHpPlayer: UILabel!
    @IBOutlet weak var enemyImg: UIImageView!
    @IBOutlet weak var chestButton: UIButton!
    
    
    //Variables
    var player: Player!
    var enemy: Enemy!
    var chestMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        player = Player(name: "Hvata", hp: 110, attackPwr: 20)
        enemy = Enemy(startingHp: 100, attackPwr: 10)
        playerHpLabel.text = "\(player.hp) HP"
    }

    func generateRandomEnemy() {
    
        let rand = Int(arc4random_uniform(2))
        
        if rand == 0 {
            enemy = Kimara(startingHp: 50, attackPwr: 12)
        }else {
            enemy = DevilWizzard(startingHp: 60, attackPwr: 15)
        }
        enemyImg.hidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - IBActions

    @IBAction func onChestPressed(sender: AnyObject) {
        chestButton.hidden = true
        printLabel.text = chestMessage
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "generateRandomEnemy", userInfo: nil, repeats: false)
        
    }

    @IBAction func attackButtonPressed(sender: AnyObject) {
       
        if enemyImg.hidden == false{
       
        if enemy.attemptAttack(player.attackPwr){
        
            printLabel.text = "Attacked \(enemy.type) for \(player.attackPwr) HP"
            enemyHpPlayer.text = "\(enemy.hp) HP"
        }else {
        
            printLabel.text = "Attack was unsuccessfull!"
        
        }
        
        if let loot = enemy.dropLoot() {
            
            player.addItemToInventory(loot)
        
            chestMessage = "\(player.name) found \(loot)"
            chestButton.hidden = false
            
        }
        if !enemy.isAlive {
            enemyHpPlayer.text = ""
            printLabel.text = "Killed \(enemy.type)"
            enemyImg.hidden = true
        
        }
      }
    
    }
    
    
    
    
    
    
    }
    
    

    
    
    
    
    
    

