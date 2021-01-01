//
//  FavoritesViewController.swift
//  Pokedex
//
//  Created by Roberts Work on 8/15/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController  {

    var pokemonAPI = PokemonAPI()
    var allPokemon = [Pokemon]()
    var favoritesPokemon = [Pokemon]()
    var favoritesPokemonMaster = [Pokemon]()
    
    //Gets the singleton object of userdefaults for favorites array
    let userDefaults = UserDefaults.standard
    
   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set tableView delegate and datasource to this view controller.
        tableView.delegate = self
        tableView.dataSource = self
        //Only call API when there are no pokemon
        if allPokemon.count == 0 {
            getApiData()
        }
    }


    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        viewLoadSetup()
        
    }
    
    func viewLoadSetup(){
       
        if allPokemon.count != 0 {
            //Clear favorites array
            favoritesPokemon = [Pokemon]()
            self.filterAllToFavorties()
        }
    }
    
    //Function to get All Pokemon data from API
    func getApiData(){
        //Only call the API if the allPokemon array is empty
            pokemonAPI.getAllPokemonAlamo { (allPokemon) in
                if let allPokemon = allPokemon {
                    self.allPokemon = allPokemon
                    self.filterAllToFavorties()
                }
            }
    }
    
    
    //Takes all the pokemon and filters down to only the favorites
    func filterAllToFavorties(){
        //Get the array of bools from user defaults
        //Array of true or false based on if the pokemon is favorited or not
        if let favorites = userDefaults.array(forKey: "favorites") as? [Bool] {
            for (index, object) in favorites.enumerated() {
                if object {
                    favoritesPokemon.append(allPokemon[index])
                }
            }
            tableView.reloadData()
            favoritesPokemonMaster = self.favoritesPokemon
        }
    }
    
    

}

//MARK: TableView Extension 
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate{
    
    //TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create new reuseable cell as a Pokemon cell then call the setupPokemonCell function
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonCell {
            
            cell.setupPokemonCell(name: favoritesPokemon[indexPath.row].name.capitalized, imageNumber: String(favoritesPokemon[indexPath.row].idNumber + 1))
            return cell
        }
        //Return empoty tableviewcell if there is an error with the custom cell.
        return UITableViewCell()
    }
    
    //Setting the tableviewcell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    //Delegate Method: Handles when the user taps a cell.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            detailVC.pokemon = favoritesPokemon[indexPath.row]
            detailVC.pokemonNumber = favoritesPokemon[indexPath.row].idNumber + 1
            detailVC.modalPresentationStyle = .fullScreen
            present(detailVC, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
