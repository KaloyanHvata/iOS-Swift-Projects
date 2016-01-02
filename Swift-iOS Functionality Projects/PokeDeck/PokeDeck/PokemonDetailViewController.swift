//
//  PokemonDetailViewController.swift
//  PokeDeck
//
//  Created by Kaloyan Petrov on 12/22/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var defenceLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    @IBOutlet weak var evolutionTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.text = pokemon.name
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = image
        currentEvolutionImage.image = image
        
        
        let q = dispatch_queue_create("pokemonQueue", nil)
        
        dispatch_async(q){
         self.pokemon.downloadPokemonDetails { () -> () in
            //this is called after download is done
            
            dispatch_async(dispatch_get_main_queue()) {
                    
                self.updateUI()
                
            }
          }
        }
    }
    
    
    func updateUI(){
        
        

      
            descriptionLabel.text = pokemon.description
            typeLabel.text = pokemon.type
            defenceLabel.text = pokemon.defense
            baseAttackLabel.text = pokemon.attack
            pokedexIdLabel.text = "\(pokemon.pokedexId)"
            weightLabel.text = pokemon.weight
            heightLabel.text = pokemon.height
        
        if pokemon.nextEvolutionId == "" {
          evolutionTextLabel.text = "No Evolutions!"
            nextEvolutionImage.hidden = true
        }else{
          nextEvolutionImage.hidden = false
          nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionId)
            
          var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            if pokemon.nextEvolutionLvl != "" {
                str += "-LVL \(pokemon.nextEvolutionLvl)"
             evolutionTextLabel.text = str
                
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    
    
    //MARK: -IBActions
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
