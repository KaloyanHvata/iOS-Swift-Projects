//
//  PokeCollectionViewCell.swift
//  PokeDeck
//
//  Created by Kaloyan Petrov on 12/20/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon){
    
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    
    }
    
}
