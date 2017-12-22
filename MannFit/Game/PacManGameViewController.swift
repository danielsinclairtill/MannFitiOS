//
//  GameViewController.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-10-30.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData

class PacManGameViewController: GameViewController, CoreDataCompliant {
    
    var managedObjectContext: NSManagedObjectContext!
    
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
        self.prepareItem(game: game, duration: duration, absement: absement)
        self.managedObjectContext.saveChanges()
    }
    
    private func prepareItem(game: String, duration: Int, absement: Float) {
        let workoutItem = NSEntityDescription.insertNewObject(forEntityName: "WorkoutItem", into: self.managedObjectContext) as! WorkoutItem
        workoutItem.game = game
        workoutItem.workoutDuration = Int64(duration)
        workoutItem.absement = absement
        workoutItem.date = Date()
        workoutItem.caloriesBurned = 0 // calculate this after
    }
    
    func exitGame() {
        self.gameCollectionDelegate?.exitGame()
    }
}
