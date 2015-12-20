//
//  MainViewController.swift
//  PokeDeck
//
//  Created by Kaloyan Petrov on 12/20/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var musicPlayer:AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        initAudio()
        parsePokemonCSV()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: IBActions
    
    @IBAction func musicButtonPressed(sender: UIButton!) {
        
        if musicPlayer.playing {
        
            musicPlayer.stop()
            sender.alpha = 0.2
            
        }else{
        
            musicPlayer.play()
            sender.alpha = 1.0
            
        }
        
    }
    
    
    
    //MARK: Helper Functions
    
    //Init Audio
    func initAudio() {
    
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        
        } catch let err as NSError {
        
         print(err.debugDescription)
        }

    
    }
    
    //Parsing CSV file
    func parsePokemonCSV() {
    
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
            
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]
                let poke = Pokemon(name:name!, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
            print(rows)
        
        }catch let err as NSError{
            
            print(err.debugDescription)
        }
    
    }
    
    //MARK: DataSOurce and Delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
        }else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil })
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCollectionViewCell {
        
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            
            return cell
            
        }else{
        
            return UICollectionViewCell()
        }
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pokemon.count
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    
    
    
    
    
    
    
}
