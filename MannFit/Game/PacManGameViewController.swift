//
//  GameViewController.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-10-30.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class PacManGameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = PacManGameScene(size: view.bounds.size)
        UIApplication.shared.isIdleTimerDisabled = true
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension PacManGameViewController: GameOverDelegate {
    func sendGameData(game: String, duration: Int, absement: Float) {
        print("game over")
    }
}
