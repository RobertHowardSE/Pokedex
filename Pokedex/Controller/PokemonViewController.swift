//
//  PokemonViewController.swift
//  Pokedex
//  
//  Created by Roberts Work on 8/13/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    //IBOUTLETS
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    //CUSTOM OBJECTS AND VARIABLES
    var pokemonAPI = PokemonAPI()
    var allPokemon = [Pokemon]()
    //This is to hold all pokemon always.
    var allPokemonMaster = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting tableview delegate and data source and search bar delegate to this view controller.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
     
        // Getting the array of allPokemen from Pokeapi
        getApiData()
        
    }
    
    //Function to get API Data
    func getApiData(){
        //Only call the API if the allPokemon array is empty
        //i.e. if the API has already been called don't call it twice.
        if allPokemonMaster.count == 0 {
            pokemonAPI.getAllPokemonAlamo { (allPokemon) in
                if let allPokemon = allPokemon {
                    //print(allPokemon)
                    self.allPokemon = allPokemon
                    self.allPokemonMaster = allPokemon
                    self.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: TableView Extension
extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    //TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create new reuseable cell as a Pokemon cell then call the setupPokemonCell function
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonCell {
            cell.setupPokemonCell(name: allPokemon[indexPath.row].name.capitalized, imageNumber: String(allPokemon[indexPath.row].idNumber + 1))
            return cell
        }
        //Return empoty tableviewcell if there is an error with the custom cell.
        return UITableViewCell()
    }
    
    //Setting the tableviewcell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    //Delegate method, when user taps on a tableview cell.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            detailVC.pokemon = allPokemon[indexPath.row]
            detailVC.pokemonNumber = allPokemon[indexPath.row].idNumber + 1
            detailVC.modalPresentationStyle = .fullScreen
            present(detailVC, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}


 //MARK: Search Bar Extension
extension PokemonViewController: UISearchBarDelegate {
   
    
    //Search Controller Delegate Methods
    
    //When user starts type or deletes filter the Pokemon based on the text in the searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == ""){
            allPokemon = allPokemonMaster
        } else {
            allPokemon = allPokemonMaster.filter{ $0.name.contains(searchText.lowercased())}
        }
        
        tableView.reloadData()
    }
    
    //Shows cancel button when the user makes the search bar active.
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //Reset back to all Pokemen and clear searchbar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        allPokemon = allPokemonMaster
        tableView.reloadData()
        searchBar.text = ""
        searchNotActive()
    }
    
    //Handle user finsihes editing event
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchNotActive()
    }
    
    //Handle search bar clicked event
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchNotActive()
    }
    
    //Search Not Active Anymore so clear cancel button and resign keyboard
    func searchNotActive(){
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}
