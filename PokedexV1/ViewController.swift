//
//  ViewController.swift
//  PokedexV1
//
//  Created by crisser-01 on 30/12/2016.
//  Copyright © 2016 crisser-01. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {

    @IBOutlet weak var collection : UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var musicPlayer : AVAudioPlayer!
    
    var filteredPokemon = [Pokemon]()
    var pokemons = [Pokemon]()
    var inSearchMode : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        parsePokemonCSV()
        initAudio()
        
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "pokemon_ending_song", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            musicPlayer.volume = 0.5
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeID)
                
                pokemons.append(poke)
                
            }
            
        } catch let err as NSError {
            print(err)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke : Pokemon!
            
            if inSearchMode {
                
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
                
            }else {
                
                poke = pokemons[indexPath.row]
                cell.configureCell(poke)
            }
            
            return cell
            
        }else {
            
            return UICollectionViewCell()
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke : Pokemon!
        
        if inSearchMode {
            
            poke = filteredPokemon[indexPath.row]
            
        }else {
            
            poke = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailsSegue", sender: poke)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredPokemon.count
            
        }else {
        
            return pokemons.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
        
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
            
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
            
        }else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemons.filter({$0.name.range(of: lower) != nil })
            
            collection.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailsSegue" {
            
            if let destination = segue.destination as? PokemondDetailVC {
                
                if let poke = sender as? Pokemon {
                    
                    destination.pokemon = poke
                }
            }
        }
        
    }
    
    

}

