//
//  DetailedPokemon.swift
//  Pokedex
//
//  Created by Roberts Work on 8/13/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import Foundation

//Creating Layers of Structs to Decode information from JSON into Detailed Pokemon Object
struct DetailedPokemon: Decodable {
    let baseExperience : Int
    let height : Int
    let types: [Type]
    let stats: [Stat]
    let pokeID: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        
        case baseExperience = "base_experience"
        case height = "height"
        case types = "types"
        case pokeID = "id"
        case name = "name"
        case stats = "stats"
        
    }
}

struct Type : Decodable {
    let type: Dictionary<String, String>
}

struct Stat : Decodable {
    let stat: StatName
    let baseStat: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case stat = "stat"
        case baseStat = "base_stat"
    }
    
}

struct StatName: Decodable {
    let name: String
}




