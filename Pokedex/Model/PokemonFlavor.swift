//
//  PokemonFlavor.swift
//  Pokedex
//
//  Created by Roberts Work on 8/14/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import Foundation


struct FlavorText : Decodable {
    let flavorText : String
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
}

struct PokemonSpecies :Decodable {
    let flavorTextEntries : [FlavorText]
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}
