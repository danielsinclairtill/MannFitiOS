//
//  GameScene.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-10-30.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    // MARK: Initilization
    enum ColliderType: UInt32 {
        case player = 1
        case food = 2
        case wall = 4
    }
    
    let motionManager = CMMotionManager()
    
    let background = SKSpriteNode()
    let scoreLabel = SKLabelNode()
    let highScoreLabel = SKLabelNode()
    var score: Int = 0
    var highscore: Int = 0
    let wall1 = SKSpriteNode()
    let wall2 = SKSpriteNode()
    let wall3 = SKSpriteNode()
    let player = SKSpriteNode(imageNamed: "pacmanPlayerOpen")
    let playerFrame1 = SKTexture(imageNamed: "pacmanPlayerOpen")
    let playerFrame2 = SKTexture(imageNamed: "pacmanPlayerClose")
    var foodSpot: SKSpriteNode?
    
    var trajectoryTimer: Timer?
    var trajectoryPath: [SKShapeNode] = []
    var shootVector: CGVector = CGVector(dx: 1, dy: 0)
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self

        // background setup
        let bounds:CGSize = frame.size
        backgroundColor = SKColor.black
        background.zPosition = -10.0
        background.scale(to: frame.size)
        
        // scoreLabel setup
        scoreLabel.zPosition = 1
        scoreLabel.fontName = "AvenirNextCondensed-Heavy"
        scoreLabel.fontSize = 50.0
        scoreLabel.fontColor = SKColor.white
        var scoreText = String(score)
        scoreLabel.text = scoreText
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: bounds.width - scoreLabel.frame.size.width / 2 - 15.0,
                                      y: bounds.height - scoreLabel.frame.size.height - 15.0)
        
        // highScoreLabel setup
        highScoreLabel.zPosition = 1
        highScoreLabel.fontName = "AvenirNextCondensed-Heavy"
        highScoreLabel.fontSize = 50.0
        highScoreLabel.fontColor = SKColor.red
        scoreText = String(score)
        highScoreLabel.text = scoreText
        highScoreLabel.horizontalAlignmentMode = .right
        highScoreLabel.position = CGPoint(x: bounds.width - highScoreLabel.frame.size.width / 2 - 15.0,
                                      y: scoreLabel.frame.minY - highScoreLabel.frame.size.height - 10.0 )
        
        // player setup
        player.zPosition = 0
        player.position = CGPoint(x: bounds.width / 2, y: player.size.height / 2 + 20.0)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.height / 2)
        player.physicsBody?.isDynamic = false
        player.physicsBody?.categoryBitMask = ColliderType.player.rawValue
        player.physicsBody?.collisionBitMask = ColliderType.wall.rawValue + ColliderType.food.rawValue
        eatingPacman()
        
        // wall setup
        wall1.zPosition = 0
        var wallPosition: CGPoint = CGPoint(x: bounds.width / 2, y: 0)
        var wallSize: CGSize = CGSize(width: bounds.width, height: 1)
        wall1.physicsBody = SKPhysicsBody(rectangleOf: wallSize, center: wallPosition)
        wall1.physicsBody?.isDynamic = false
        wall1.physicsBody?.categoryBitMask = ColliderType.wall.rawValue
        
        wall2.zPosition = 0
        wallPosition = CGPoint(x: 0, y: bounds.height / 2)
        wallSize = CGSize(width: 1, height: bounds.height)
        wall2.physicsBody = SKPhysicsBody(rectangleOf: wallSize, center: wallPosition)
        wall2.physicsBody?.isDynamic = false
        wall2.physicsBody?.categoryBitMask = ColliderType.wall.rawValue
        
        wall3.zPosition = 0
        wallPosition = CGPoint(x: bounds.width, y: bounds.height / 2)
        wallSize = CGSize(width: 1, height: bounds.height)
        wall3.physicsBody = SKPhysicsBody(rectangleOf: wallSize, center: wallPosition)
        wall3.physicsBody?.isDynamic = false
        wall3.physicsBody?.categoryBitMask = ColliderType.wall.rawValue
        
        // add nodes
        addChild(background)
        addChild(scoreLabel)
        addChild(highScoreLabel)
        addChild(wall1)
        addChild(wall2)
        addChild(wall3)
        addChild(player)
        
        // setup food
        refreshFood()
        
        // setup motion
        motionManager.startAccelerometerUpdates()
    }

    private func refreshFood() {
        if let food = foodSpot {
            food.removeFromParent()
            foodSpot = nil
        }
        foodSpot = SKSpriteNode(imageNamed: "pacmanFood")
        if let food = foodSpot {
            let bounds:CGSize = frame.size
            food.zPosition = 0
            let randomXPos:CGFloat = CGFloat(arc4random_uniform(UInt32(bounds.width - food.size.width) - 40))
            food.position = CGPoint(x: 20.0 + food.size.width + randomXPos, y: bounds.height)
            food.physicsBody = SKPhysicsBody(circleOfRadius: food.size.height / 2)
            food.physicsBody?.isDynamic = true
            food.physicsBody?.categoryBitMask = ColliderType.food.rawValue
            food.physicsBody?.contactTestBitMask = ColliderType.player.rawValue
            food.physicsBody?.collisionBitMask = 0
            addChild(food)
        }
    }
    
    // MARK: Pacman Animations
    private func eatingPacman() {
        player.run(SKAction.repeatForever(
            SKAction.animate(with: [playerFrame1, playerFrame2],
                                         timePerFrame: 0.2,
                                         resize: false,
                                         restore: true)),
                                         withKey:"eatingPacman")
    }
    
    private func updateScore(_ score: Int) {
        if score > self.highscore {
            self.highscore = score
            let scoreText = String(score)
            highScoreLabel.text = scoreText
        }
        self.score = score
        let scoreText = String(score)
        scoreLabel.text = scoreText
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        
        // food update
        if let food = foodSpot {
            if food.position.y <= 0 {
                refreshFood()
                updateScore(0)
            }
            food.position.y -= 10
        }
        
        // motion update
        if let data = motionManager.accelerometerData {
            player.position.x = CGFloat(data.acceleration.x) * frame.width / 2 * 2 + frame.width / 2
        }
    }
}

// MARK: Contacts
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        // Edge Contact
        if bodyA.categoryBitMask == ColliderType.food.rawValue || bodyB.categoryBitMask == ColliderType.food.rawValue {
            refreshFood()
            updateScore(score + 1)
        }
    }
}

