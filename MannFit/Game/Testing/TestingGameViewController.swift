//
//  TestingGameViewController.swift
//  MannFit
//
//  Created by Daniel Till on 1/24/18.
//  Copyright © 2018 MannFit Labs. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData

class TestingGameViewController: UIViewController, CoreDataCompliant {
    
    var managedObjectContext: NSManagedObjectContext!
    private var scene: TestingGameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        self.scene = TestingGameScene(size: view.bounds.size)
        scene?.gameOverDelegate = self
        UIApplication.shared.isIdleTimerDisabled = true
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene?.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func exit() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TestingGameViewController: GameOverPromptDelegate {
    func restartGame() {
        // first dismiss popup
        self.dismiss(animated: true, completion: nil)
        //self.scene?.restartGame()
    }
    
    func exitGame() {
        // first dismiss popup
        self.dismiss(animated: true, completion: nil)
        self.exit()
    }
}

extension TestingGameViewController: GameOverDelegate {
    
    func presentPrompt() {
        let view = GameOverPromptView()
        view.delegate = self
        let popup = PopUpViewController(view: view, dismissible: false)
        self.present(popup, animated: true, completion: nil)
    }
    
    func sendGameData(game: String, duration: Int, absement: Float) {
    }
}
