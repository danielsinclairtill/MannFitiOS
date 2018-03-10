//
//  PongGameScene.swift
//  MannFit
//
//  Created by Daniel Till on 10/3/18.
//  Copyright © 2018 MannFit Labs. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class PongGameScene: SKScene {
    
    // MARK: Initilization
    weak var gameOverDelegate: GameOverDelegate?

    var inputTime: TimeInterval = GameData.pacmanDefaultTime
}
