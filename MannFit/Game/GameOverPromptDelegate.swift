//
//  GameOverPromptDelegate.swift
//  MannFit
//
//  Created by Daniel Till on 12/1/17.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import Foundation

/// Delegate to handle logic for buttons presented from the Game Over prompt of a game
protocol GameOverPromptDelegate: NSObjectProtocol {
    func restartGame() -> Void
    func exitGame() -> Void
}
