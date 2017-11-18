import SpriteKit
import GameplayKit
import CoreMotion


class GameScene: SKScene {
    
    // MARK: Initilization
    enum ColliderType: UInt32 {
        case player = 1
        case food = 2
        case line = 4
        case wall = 8
    }
    
    let motionManager = CMMotionManager()
    
    let background = SKSpriteNode()
    let scoreLabel = SKLabelNode()
    let highScoreLabel = SKLabelNode()
    var score: Int = 0
    var highscore: Float = 0
    let wall1 = SKSpriteNode()
    let wall2 = SKSpriteNode()
    let wall3 = SKSpriteNode()
    let player = SKSpriteNode(imageNamed: "pacmanPlayerOpen")
    var playerRelativeYPosition: CGFloat = 20.0
    let playerFrame1 = SKTexture(imageNamed: "pacmanPlayerOpen")
    let playerFrame2 = SKTexture(imageNamed: "pacmanPlayerClose")
    var balancePath: BalancePath?
    var balancePathNode: SKShapeNode = SKShapeNode()
    
    var engine: AudioEngine?
    
    override func didMove(to view: SKView) {
        
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
        player.scale(to: CGSize(width: 10.0, height: 10.0))
        player.position = CGPoint(x: bounds.width / 2, y: playerRelativeYPosition)
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
        
        // initiate balance path
        balancePath = BalancePath(origin: CGPoint(x: bounds.width / 2, y: 100.0), length: 500.0 , bounds: bounds, distanceToBottom: 20.0)
        if let balancePath = balancePath {
            balancePathNode.zPosition = 0
            balancePathNode.path = balancePath.path
            balancePathNode.lineWidth = 5.0
            balancePathNode.strokeColor = UIColor.white
            balancePathNode.physicsBody = SKPhysicsBody(edgeChainFrom: balancePath.path)
            balancePathNode.physicsBody?.isDynamic = false
            addChild(balancePathNode)
        }
        
        // setup motion
        motionManager.startAccelerometerUpdates()
        
        guard let engine = AudioEngine(with: "pacman_beginning", type: "wav", options: .loops) else { return }
        
        self.engine = engine
        self.engine!.setupAudioEngine()
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
        self.score = score
        var scoreText = String(score)
        scoreLabel.text = scoreText
        self.highscore += Float(score) / 100.0
        scoreText = String(highscore)
        highScoreLabel.text = scoreText
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        
        // motion update
        if let data = motionManager.accelerometerData {
            player.position.x = CGFloat(data.acceleration.x) * frame.width / 2 * 2 + frame.width / 2
        }
        
        // check path difference
        var xDifference: CGFloat = 0.0
        if let balancePath = balancePath {
            balancePathNode.position.y -= 1
            playerRelativeYPosition += 1
            let relativePlayerPosition = CGPoint(x: player.position.x, y: playerRelativeYPosition)
            xDifference = balancePath.differenceFromPathPoint(relativePlayerPosition)
            
            // extend path
            if balancePath.totalLength - playerRelativeYPosition <= frame.height {
                balancePath.appendBalancePathWithRandomSegment(length: 500.0, amplification: 0.8)
            }

            balancePathNode.path = balancePath.path
        }
        updateScore(Int(xDifference))
        self.engine!.modifyPitch(with: -Float(xDifference * 2))
    }
}
