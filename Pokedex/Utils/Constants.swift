//
//  Constants.swift
//  Pokedex
//
//  Created by Roberts Work on 8/13/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import UIKit

let URL_BASE = "https://pokeapi.co/api/v2/"

let POKEMON_URL = URL_BASE + "pokemon/"
let POKEMON_SPECIES_URL = URL_BASE + "pokemon-species/"

typealias PokemonResponseCompletion = ([Pokemon]?) -> Void
typealias DetailedPokemonResponseCompletion = (DetailedPokemon?) -> Void
typealias PokemonSpeciesResponseCompletion = (PokemonSpecies?) -> Void
