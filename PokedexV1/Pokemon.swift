//
//  Pokemon.swift
//  PokedexV1
//
//  Created by crisser-01 on 30/12/2016.
//  Copyright © 2016 crisser-01. All rights reserved.
//

import Foundation


class Pokemon {
    
    fileprivate var _name : String!
    fileprivate var _pokedexId : Int!
    
    var name : String {
        
        return _name
    }
    
    var pokedexId : Int {
        
        return _pokedexId
    }
    
    init(name: String , pokedexId: Int){
        
        self._name = name
        self._pokedexId = pokedexId
        
    }
    
    
}
