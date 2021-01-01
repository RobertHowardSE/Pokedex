//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Roberts Work on 8/13/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    //Function to set up UI for the PokemonCell
    func setupPokemonCell(name: String, imageNumber: String){
        
        var pokemonNumber : String
        
        nameLabel.text = name
        pokemonImage.image = UIImage(named: imageNumber)
        
        //Convert imageNumber to have leading 0s
        if(imageNumber.count == 1){
           pokemonNumber = "00" + imageNumber
        } else if (imageNumber.count == 2){
            pokemonNumber = "0" + imageNumber
        } else {
            pokemonNumber = imageNumber
        }
        numberLabel.text = "#\(pokemonNumber)"
        
    }
    
    
    
}
