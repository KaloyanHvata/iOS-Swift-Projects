//
//  Kimara.swift
//  RPG-OOP
//
//  Created by Kaloyan Petrov on 12/11/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import Foundation

class Kimara: Enemy {

    let IMMUNE_MAX = 15
    
    override var loot: [String] {
    
        return ["Tough Hude", "Kimara Venom", "Rare Trident"]
    }
    
    override var type:String {
        return "Kimara"
    }
    override func attemptAttack(attackPwr: Int) -> Bool {
        
        if attackPwr >= IMMUNE_MAX {
            return super.attemptAttack(attackPwr)
        }else{
            return false
        
        }
    }
}