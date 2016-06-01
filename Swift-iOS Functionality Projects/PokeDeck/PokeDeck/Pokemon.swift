//
//  Pokemon.swift
//  PokeDeck
//
//  Created by Kaloyan Petrov on 12/15/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    var name: String!
    var pokedexId: Int!
    var description: String? = nil
    var type: String? = nil
    var defense: String? = nil
    var height: String? = nil
    var weight: String? = nil
    var attack: String? = nil
    var nextEvolutionTxt: String? = nil
    var nextEvolutionId: String? = nil
    var nextEvolutionLvl: String? = nil
    //the resource url
    var resourceUrl: String!
    
    //Creating initializer
    init(name: String, pokedexId: Int){
        
        self.name = name
        self.pokedexId = pokedexId
        
        resourceUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    
    //Parsing JSON from the API
    func downloadPokemonDetails(completed: DownloadComplete) {

        let url = NSURL(string: self.resourceUrl)!
        
        Alamofire.request(.GET,url).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                
                self.weight = dict["weight"] as? String ?? "0"
                
                self.height = dict["height"] as? String ?? "0"
                
                self.attack = "\(dict["attack"] as? Int)" ?? "(0)"
               
                self.defense = "\(dict["defense"] as? Int)" ?? "(0)"
                
                
                if let types = dict["types"] as? [Dictionary <String, String>] where types.count > 0{
                    
                    if let name = types[0]["name"]{
                        
                        self.type = name.capitalizedString
                        
                    }
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"]{
                                
                                self.type! += "/\(name.capitalizedString)"
                                
                            }
                        }
                    }
                    
                }else{
                    
                    self.type = ""
                    
                }
                
                print(self.type)
                if let descriptionArray = dict["descriptions"] as? [Dictionary <String, String>] where descriptionArray.count > 0,
                    let url = descriptionArray[0]["resource_uri"] {
                    
                    let nsUrl = NSURL(string: "\(URL_BASE)\(url)")!
                    Alamofire.request(.GET, nsUrl).responseJSON{ response in
                        
                        let  descriptResult = response.result
                        if let descriptDict = descriptResult.value as? Dictionary<String, AnyObject> {
                            
                            if let description = descriptDict["description"] as? String {
                                
                                self.description = description
                                print(self.description)
                            }
                        }
                        completed()
                    }
                }else{
                    
                    self.description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String{
                        //Case that word "Mega" is not found and we are good to go
                        //Can't support mega pokemon at this time but API still sends it
                        if to.rangeOfString("mega") == nil{
                            
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                self.nextEvolutionId = num
                                self.nextEvolutionTxt = to
                                
                                if let lvl = evolutions[0]["level"] as? Int{
                                    
                                    self.nextEvolutionLvl = "\(lvl)"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}















