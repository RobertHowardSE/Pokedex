//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Roberts Work on 8/13/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class DetailViewController: UIViewController {

  
    
    //IBOUTLETS
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var bgView: BGColorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var specialAttackLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var specialDefenseLabel: UILabel!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var transitionImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    //Custom Objects and Variables
    var pokemon : Pokemon!
    var pokemonNumber : Int!
    var detailedPokemon : DetailedPokemon!
    var detailedPokemonAPI = DetailedPokemonAPI()
    var pokemonSpecies : PokemonSpecies!
    var pokemonSpeciesAPI = PokemonSpeciesAPI()
    
    //Targeting user defaults singleton to get the favorties
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Play transition pokeball while API calls are being made.
        transitionImage.image = UIImage.gif(name: "transition")
        
        
        if let pokemon = pokemon {
            pokemonImageView.image = UIImage(named: String(pokemonNumber))
            nameLabel.text = pokemon.name.capitalized
            getDetailedPokemonData()
            updateFavoritesUI()
        }
        
    
    }
    
    
    
    //MARK: API Methods
    
    func getDetailedPokemonData(){
        detailedPokemonAPI.getDetailedPokemonAlamo(id: pokemonNumber, completion: { (detailedPokemon) in
            if let detailedPokemon = detailedPokemon {
                //print(detailedPokemon)
                self.detailedPokemon = detailedPokemon
                self.setStatsUI()
            }
           
        })
        
    }
    
    
    //This function gets the Description Text from the Species API
    func getSpeciesPokemonData(){
        pokemonSpeciesAPI.getPokemonSpeciesAlamo(id: pokemonNumber) { (pokemonSpecies) in
            if let pokemonSpecies = pokemonSpecies {
                self.pokemonSpecies = pokemonSpecies
                self.setupDescriptionTextUI()
            }
            //API now done updating data, so call clear loading screen functionality
           self.clearLoadingScreen()
        }
    }
    
    //MARK: API to seting up UI Methods
    
    //Sets up the UI for the description text
    func setupDescriptionTextUI(){
        for (index, object) in pokemonSpecies.flavorTextEntries.enumerated() {
            //Need to make sure that the language is english.
            if(object.language.name == "en") {
                //Clear the line breaks in the description
                let filteredDescription = pokemonSpecies.flavorTextEntries[index].flavorText.replacingOccurrences(of: "\n", with: " ")
                descriptionLabel.text =  filteredDescription
                break
            }
            
        }
    }
    
    
    //Clears the Loading Screen after API is finished Loading data and updating UI
    func clearLoadingScreen() {
        coverView.isHidden = true
        transitionImage.image = UIImage()
        transitionImage.isHidden = true
    }
    
    
    //Sets the stats UI on bottom of DetailVC
    func setStatsUI(){
        for (_, object) in detailedPokemon.stats.enumerated() {
            
            //Add Leading Zeros to Stats
            var baseStatString = String(object.baseStat)
            if(baseStatString.count == 1){
                baseStatString = "00\(baseStatString)"
            } else if baseStatString.count == 2 {
                baseStatString = "0\(baseStatString)"
            }
            
            //Based on the object name, set the stat to the corresponding label
            switch object.stat.name {
            case "hp":
                hpLabel.text = baseStatString
            case "speed":
                speedLabel.text = baseStatString
            case "attack":
                attackLabel.text = baseStatString
            case "special-defense":
                specialDefenseLabel.text = baseStatString
            case "special-attack":
                specialAttackLabel.text = baseStatString
            case "defense":
                defenseLabel.text = baseStatString
            default :
                break
            }
        }
        
        //Set the background color and type tag image based on the type of the Pokemon
        if let typeName = detailedPokemon.types[detailedPokemon.types.count - 1].type["name"] {
            typeImage.image = UIImage(named: typeName.capitalized)
            bgView.setColor(type: typeName)
            getSpeciesPokemonData()
        }
        
    }
    
    //MARK: Favorties functionality
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        
        // Load favorites array of 0s and 1s and make changes to the favorite status of the current pokemen
        var favorites = userDefaults.array(forKey: "favorites") as! [Bool]
        
        //Checks if the image is hollow (not favortied so favortie) or solid (Already Favorited so Unfavorite)
        if (favoriteButton.currentImage?.isEqual(UIImage(named: "favorite-hallow")))!{
            favorites[pokemonNumber - 1] = true
        } else {
            favorites[pokemonNumber - 1] = false
        }
        
        //Updates the user defaults because changes have been made.
        userDefaults.set(favorites, forKey: "favorites")
        
        //Updates the heart images to either be hollow or solid
        updateFavoritesUI()
        
    }
    
    //Updates the heart images to either be hollow or solid
    func updateFavoritesUI(){
        
        let favorites = userDefaults.array(forKey: "favorites") as! [Bool]
        
        if(favorites[pokemonNumber - 1]){
            favoriteButton.setImage(UIImage(named: "favorite-solid"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite-hallow"), for: .normal)
        }
        
    }
    
 
    //MARK: Backbutton functionality
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
