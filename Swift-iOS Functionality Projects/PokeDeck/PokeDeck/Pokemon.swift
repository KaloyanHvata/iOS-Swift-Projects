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
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    //the resource url
    private var _resourceUrl: String!
    
    // "/api/v1/pokemon/1/"
    
    //Create getters (computed properties)
    var name:String{
        get{
            if _name == nil {
               _name = ""
            }
            return _name
        }
    }
    
    var pokedexId: Int {
        get{
            if _pokedexId == nil {
               _pokedexId = 0
            }
            return _pokedexId
        }

    }
    
    
    var description: String {
        get{
            if _description == nil {
               _description = ""
            }
            return _description!
        }
    }
    
    var type:String {
        get{
            if _type == nil {
               _type = ""
            }
            return _type
        }
    }
    
    var height:String {
        get{
            if _height == nil {
                _height = ""
            }
            return _height
        }
    }
    
    var weight:String {
        get{
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }
    }
    
    var attack:String{
        get{
            if _attack == nil {
                _attack = ""
            }
            return _attack
        }
    }
    
    var defense:String{
        get{
            if _defense == nil {
                _defense = ""
            }
            return _defense
        }
    }
    
    var nextEvolutionTxt:String{
        get{
            if _nextEvolutionTxt == nil {
                _nextEvolutionTxt = ""
            }
            return _nextEvolutionTxt
        }
    }
    var nextEvolutionId:String{
        get{
            if _nextEvolutionId == nil {
                _nextEvolutionId = ""
            }
            return _nextEvolutionId
        }
    }
    var nextEvolutionLvl:String{
        get{
            if _nextEvolutionLvl == nil {
                _nextEvolutionLvl = ""
            }
            return _nextEvolutionLvl
        }
    }
    
    
    //Creating initializer
    init(name: String, pokedexId: Int){
        
        self._name = name
        self._pokedexId = pokedexId
        
        _resourceUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }

    
    //Parsing JSON from the API
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _resourceUrl)!
        
        Alamofire.request(.GET,url).responseJSON { response in
            let result = response.result
            print(result.value.debugDescription)
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary <String, String>] where types.count > 0{
                
                    if let name = types[0]["name"]{
                    
                        self._type = name.capitalizedString
                        
                    }
                    if types.count > 1 {
                        
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"]{
                            
                                self._type! += "/\(name.capitalizedString)"
                                
                            }
                        }
                    }
                    
                }else{
                    
                    self._type = ""
                
                }
                
                  print(self._type)
                if let descriptionArray = dict["descriptions"] as? [Dictionary <String, String>] where descriptionArray.count > 0 {
                
                    if let url = descriptionArray[0]["resource_uri"]{
                        
                        let nsUrl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsUrl).responseJSON{ response in
                            
                            let  descriptResult = response.result
                            if let descriptDict = descriptResult.value as? Dictionary<String, AnyObject> {
                            
                                if let description = descriptDict["description"] as? String {
                                
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                    }
                    
                }else{
                
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String{
                        //Case that word "Mega" is not found and we are good to go
                        //Can't support mega pokemon at this time but API still sends it
                        if to.rangeOfString("mega") == nil{
                        
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = num
                                self._nextEvolutionTxt = to
                                
                                if let lvl = evolutions[0]["level"] as? Int{
                                
                                    self._nextEvolutionLvl = "\(lvl)"
                                }
//                                print(self._nextEvolutionLvl)
//                                print(self._nextEvolutionId)
//                                print(self._nextEvolutionTxt)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
}