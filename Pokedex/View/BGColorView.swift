//
//  BGColorView.swift
//  Pokedex
//
//  Created by Roberts Work on 8/14/19.
//  Copyright © 2019 Robert Howard. All rights reserved.
//

import UIKit

class BGColorView: UIView {
    //Sets the color of the background based on the Pokemon type
    func setColor(type: String){
        
        var color: CGColor
        
        switch type {
        case "bug":
            color = BUG
        case "dark":
            color = DARK
        case "dragon":
            color = DRAGON
        case "electric":
            color = ELECTRIC
        case "fairy":
            color = FAIRY
        case "fighting":
            color = FIGHT
        case "fire":
            color = FIRE
        case "flying":
            color = FLYING
        case "ghost":
            color = GHOST
        case "grass":
            color = GRASS
        case "ground":
            color = GROUND
        case "ice":
            color = ICE
        case "normal":
            color = NORMAL
        case "poison":
            color = POISON
        case "psychic":
            color = PSYCHIC
        case "rock":
            color = ROCK
        case "steel":
            color = STEEL
        case "water":
            color = WATER
        default:
            color = UIColor.blue.cgColor
        }
        
        layer.backgroundColor = color

        
    }

}
