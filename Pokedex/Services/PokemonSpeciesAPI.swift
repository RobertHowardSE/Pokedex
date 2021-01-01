//
//  FlavorsPokemonAPI.swift
//  Pokedex
//
//  Created by Roberts Work on 8/14/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//
import Foundation
import Alamofire


class PokemonSpeciesAPI {
    func getPokemonSpeciesAlamo(id: Int, completion: @escaping PokemonSpeciesResponseCompletion) {
        //Adding the id to the url to look up specific pokemon
        guard let url = (URL(string: "\(POKEMON_SPECIES_URL)\(id)")) else {return}

        Alamofire.request(url).responseJSON { (response) in
            //Check to make sure there are no errors
            if let error = response.error {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            //Check to make sure there is data
            guard let data = response.data else {
                completion(nil)
                return
            }
            //Set up json decoder
            let jsonDecoder = JSONDecoder()
            
            //Decode data into PokemonSpecies Object and pass to completion handler 
            do{
                let pokemonSpecies = try jsonDecoder.decode(PokemonSpecies.self, from: data)
                completion(pokemonSpecies)
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
        }
    }
}
