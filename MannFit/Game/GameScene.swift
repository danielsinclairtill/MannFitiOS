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
import AVFoundation

class GameScene: SKScene {
    
    // MARK: Food Paths
    struct foodPathPresets {
        static let tenFoodMiddle: [CGFloat] = [0, 0, 0, 0, 0]
        static let tenFoodLeft: [CGFloat] = [-10, -10, -10, -10, -10]
        static let tenFoodRight: [CGFloat] = [10, 10, 10, 10, 10]
        static let middleToLeft: [CGFloat] = [0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10]
        static let middleToRight: [CGFloat] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        static let leftToMiddle: [CGFloat] = [-10, -9, -8, -7, -6, -5, -4 ,-3, -2, -1, 0]
        static let rightToMiddle: [CGFloat] = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    }
    
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
    var foodPathTimer: Timer?
    var foodPath: [CGFloat] = []
    var foodSpots: [SKSpriteNode] = []
    var lastFoodPos: CGFloat = 0.0
    
    var trajectoryTimer: Timer?
    var trajectoryPath: [SKShapeNode] = []
    var shootVector: CGVector = CGVector(dx: 1, dy: 0)
    
    let engine = AVAudioEngine()
    let audioPlayerNode = AVAudioPlayerNode()
    let unitTimePitch = AVAudioUnitTimePitch()
    
    var audioBuffer: AVAudioPCMBuffer?
    
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
        foodPath = foodPathPresets.tenFoodMiddle
        if let lastFood = foodPath.last {
            lastFoodPos = lastFood
        }
        startFoodPath()
        
        // setup motion
        motionManager.startAccelerometerUpdates()

        guard let buffer = self.setupFileBuffer(with: "pacman_beginning", type: "wav") else {
            return
        }
        
        self.audioBuffer = buffer
        self.setupAudioEngine(with: self.audioBuffer!)
    }
    
    private func setupFileBuffer(with file: String, type: String) -> AVAudioPCMBuffer? {
        let resource = Bundle.main.path(forResource: file, ofType: type)
        
        guard let filePath = resource else {
            return nil
        }
        
        let url = NSURL.fileURL(withPath: filePath)
        
        do {
            let audioFile = try AVAudioFile(forReading: url)
            let audioFormat = audioFile.processingFormat
            let audioFrameCount = AVAudioFrameCount(audioFile.length)
            let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)
            
            guard let buffer = audioFileBuffer else {
                return nil
            }
            
            try audioFile.read(into: buffer)
            
            return audioFileBuffer
        } catch {
            return nil
        }
    }

    private func setupAudioEngine(with audioFileBuffer: AVAudioPCMBuffer) {
        self.engine.attach(self.audioPlayerNode)
        self.engine.attach(self.unitTimePitch)
        
        self.engine.connect(self.audioPlayerNode, to: self.unitTimePitch, format: audioFileBuffer.format)
        self.engine.connect(self.unitTimePitch, to: self.engine.mainMixerNode, format: audioFileBuffer.format)
        
        self.audioPlayerNode.scheduleBuffer(audioFileBuffer, at: nil, options: .loops, completionHandler: nil)
        
        do {
            try self.engine.start()
            self.audioPlayerNode.play()
        } catch {
            //TODO: - Error handling
            print("Error. Handle this")
            fatalError()
        }
    }
    
    private func modifyPitch(with value: Float) {
        self.unitTimePitch.pitch = value
        self.audioPlayerNode.scheduleBuffer(self.audioBuffer!, at: nil, options: .loops, completionHandler: nil)
    }
    
    private func startFoodPath() {
        foodPathTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refreshFood), userInfo: nil, repeats: true)
    }
    
//    @objc private func refreshFood() {
//        if let food = foodSpot {
//            food.removeFromParent()
//            foodSpot = nil
//        }
//        foodSpot = SKSpriteNode(imageNamed: "pacmanFood")
//        if let food = foodSpot {
//            let bounds:CGSize = frame.size
//            food.zPosition = 0
//            let randomXPos:CGFloat = CGFloat(arc4random_uniform(UInt32(bounds.width - food.size.width) - 40))
//            food.position = CGPoint(x: 20.0 + food.size.width + randomXPos, y: bounds.height)
//            food.physicsBody = SKPhysicsBody(circleOfRadius: food.size.height / 2)
//            food.physicsBody?.isDynamic = true
//            food.physicsBody?.categoryBitMask = ColliderType.food.rawValue
//            food.physicsBody?.contactTestBitMask = ColliderType.player.rawValue
//            addChild(food)
//        }
//    }

    
    @objc private func refreshFood() {
        if foodPath.isEmpty {
            if lastFoodPos == 0 {
                let presetVariations = [foodPathPresets.tenFoodMiddle, foodPathPresets.middleToLeft, foodPathPresets.middleToRight]
                appendToFoodPathWithRandomPresets(presetVariations)
            }
            else if lastFoodPos == 10 {
                let presetVariations = [foodPathPresets.tenFoodRight, foodPathPresets.rightToMiddle]
                appendToFoodPathWithRandomPresets(presetVariations)
            }
            else if lastFoodPos == -10 {
                let presetVariations = [foodPathPresets.tenFoodLeft, foodPathPresets.leftToMiddle]
                appendToFoodPathWithRandomPresets(presetVariations)
            }
        }
        if foodPath.isEmpty == false {
            let food = (SKSpriteNode(imageNamed: "pacmanFood"))
            let bounds:CGSize = frame.size
            food.zPosition = 0
            var variation: CGFloat = 0
            if let nextPos = foodPath.first {
                variation = ((bounds.width - 20.0 - food.size.width) / 2.0) / 10.0 * nextPos
                foodPath.removeFirst()
            }
            let positionX = (bounds.width / 2.0) + variation
            food.position = CGPoint(x: positionX, y: bounds.height + food.size.height)
            food.physicsBody = SKPhysicsBody(circleOfRadius: food.size.height / 2)
            food.physicsBody?.isDynamic = true
            food.physicsBody?.affectedByGravity = false
            food.physicsBody?.categoryBitMask = ColliderType.food.rawValue
            food.physicsBody?.contactTestBitMask = ColliderType.player.rawValue
            food.physicsBody?.collisionBitMask = 0
            
            foodSpots.append(food)
            addChild(food)
        }
    }

    private func removeFood(_ food: SKSpriteNode) {
        food.removeFromParent()
        let indexOfFood = foodSpots.index{$0 === food}
        if let index = indexOfFood {
            foodSpots.remove(at:index)
        }
    }
    
    private func appendToFoodPathWithRandomPresets(_ presetVariations: [[CGFloat]]) {
        let randomIndex:Int = Int(arc4random_uniform(UInt32(presetVariations.count)))
        foodPath += presetVariations[randomIndex]
        if let lastFood = foodPath.last {
            lastFoodPos = lastFood
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
        for food in foodSpots {
            if food.position.y <= 0 {
                removeFood(food)
                updateScore(0)
            }
            food.position.y -= 5
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
        if bodyA.categoryBitMask == ColliderType.food.rawValue {
            if let food = contact.bodyA.node as? SKSpriteNode {
                removeFood(food)
                updateScore(score + 1)
            }
        }
        else if bodyB.categoryBitMask == ColliderType.food.rawValue {
            if let food = contact.bodyB.node as? SKSpriteNode {
                removeFood(food)
                updateScore(score + 1)
            }
        }
    }
}

