//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Roberts Work on 8/14/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import Foundation

//Creating Layers of Structs to Decode information from JSON into PokemonSpecies Object

struct PokemonSpecies : Decodable {
    //Array of decription text with langauge of the text
    let flavorTextEntries : [FlavorText]
    
    enum  CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
        
    }
    
}

//Description of specific pokemon with language
struct FlavorText : Decodable {
    
    let flavorText : String
    let language: LanguageName
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language = "language"
    }
    
}

struct LanguageName : Decodable {
    
    let name: String
    
}

