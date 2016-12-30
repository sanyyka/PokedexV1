//
//  PokemondDetailVC.swift
//  PokedexV1
//
//  Created by crisser-01 on 30/12/2016.
//  Copyright © 2016 crisser-01. All rights reserved.
//

import UIKit

class PokemondDetailVC: UIViewController {

    var pokemon : Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       nameLbl.text = pokemon.name
        
    }

}
