//
//  PokeCell.swift
//  PokedexV1
//
//  Created by crisser-01 on 30/12/2016.
//  Copyright © 2016 crisser-01. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    
    var pokemon : Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    
    func configureCell(_ pokemon : Pokemon) {
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        
        thumbImg.image = UIImage(named: ("\(self.pokemon.pokedexId)"))
        
    }
    
    
    
}
