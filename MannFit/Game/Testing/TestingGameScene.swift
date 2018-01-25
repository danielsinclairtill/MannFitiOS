//
//  TestingGameScene.swift
//  MannFit
//
//  Created by Daniel Till on 1/24/18.
//  Copyright © 2018 MannFit Labs. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class TestingGameScene: SKScene {
    private let motionManager = CMMotionManager()
    private let userDefaults: UserDefaults = UserDefaults.standard
    weak var gameOverDelegate: GameOverDelegate?
    
    private var gameActive: Bool = true
    private var timeLabel = SKLabelNode()
    
    private let background = SKSpriteNode()
    private let xLabel = SKLabelNode()
    private let yLabel = SKLabelNode()
    private let zLabel = SKLabelNode()
    private var x: Double = 0
    private var y: Double = 0
    private var z: Double = 0
    private let stopButton = SKSpriteNode(imageNamed: "menu-icon")
    
    var smoothXAcceleration = LowPassFilterSignal(value: 0, timeConstant: 0.90)
    
    override func didMove(to view: SKView) {
        
        // background setup
        let bounds:CGSize = frame.size
        backgroundColor = SKColor.black
        background.zPosition = -10.0
        background.scale(to: frame.size)
        
        // xLabel setup
        xLabel.zPosition = 1
        xLabel.fontName = "AvenirNextCondensed-Heavy"
        xLabel.fontSize = 50.0
        xLabel.fontColor = SKColor.white
        var scoreText = String(x)
        xLabel.text = scoreText
        xLabel.horizontalAlignmentMode = .left
        xLabel.position = CGPoint(x: 10.0, y: bounds.height - xLabel.frame.size.height - 15.0)
        
        // yLabel setup
        yLabel.zPosition = 1
        yLabel.fontName = "AvenirNextCondensed-Heavy"
        yLabel.fontSize = 50.0
        yLabel.fontColor = SKColor.red
        scoreText = String(y)
        yLabel.text = scoreText
        yLabel.horizontalAlignmentMode = .left
        yLabel.position = CGPoint(x: xLabel.position.x,
                                  y: xLabel.frame.minY - yLabel.frame.size.height - 10.0 )
        
        // stopButton setup
        stopButton.zPosition = 1
        stopButton.size = CGSize(width: 60.0, height: 60.0)
        stopButton.position = CGPoint(x: bounds.width - stopButton.frame.width - 10.0,
                                      y: bounds.height - xLabel.frame.size.height - 15.0)
        
        // add nodes
        addChild(background)
        addChild(xLabel)
        addChild(yLabel)
        addChild(stopButton)
        
        // motion setup
        motionManager.startAccelerometerUpdates()
    }
}
