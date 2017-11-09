//
//  Game.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-11-08.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit

struct Game {
    let gameName: String
    let gameImageName: String
}

extension Game {
    var gameImage: UIImage {
        return UIImage(named: self.gameImageName)!
    }
}
