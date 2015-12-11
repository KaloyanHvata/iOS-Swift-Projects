//
//  DevilWizzard.swift
//  RPG-OOP
//
//  Created by Kaloyan Petrov on 12/11/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import Foundation

class DevilWizzard: Enemy {

    override var loot: [String] {
    
        return ["Magic Wand", "Dark Amulet", "Salted Pork" , "Old Tobby"]
    }
    
    override var type: String {
        return "Devil Wizzard"
    
    }
}