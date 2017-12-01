//
//  GameOverPromptDelegate.swift
//  MannFit
//
//  Created by Daniel Till on 12/1/17.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import Foundation

protocol GameOverPromptDelegate {
    func restartGame() -> Void
    func exitGame() -> Void
}
