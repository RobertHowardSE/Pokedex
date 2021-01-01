//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Roberts Work on 8/13/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PokemonAPI {
    
    func getAllPokemonAlamo(completion: @escaping PokemonResponseCompletion) {
        
        //Covert url string to URL and make sure it doesn't return nil, exit function if it does
        guard let url = URL(string: POKEMON_URL) else { return }
        
        //Make Get Request to PokeAPI to recieve all pokemon with Alamofire
        Alamofire.request(url, method: .get, parameters: ["limit": 718]).responseJSON { (response) in
            
            //Make sure there is no error in the response if so send completion handler nil and return
            if let error = response.error {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }

            //Make sure there is data
            guard let data = response.data else {return}
            
            //Do Try Catch for converting data to JSON
            do{
                let json = try JSON(data: data)
                let allPokemon = self.parsePokemonSwifty(json: json)
                completion(allPokemon)
            }catch{
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func parsePokemonSwifty(json: JSON) -> [Pokemon] {
        var allPokemon = [Pokemon]()
        //Pulling out the information from the json array and creating the array of all Pokemon 
        for (index , object) in json["results"] {
            allPokemon.append(Pokemon(name: object["name"].stringValue, url: object["url"].stringValue, idNumber: Int(index)!))
        }
        return allPokemon
    }
    
    
    
}
