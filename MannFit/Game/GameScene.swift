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
    let absementLabel = SKLabelNode()
    let absementScoreLabel = SKLabelNode()
    var absement: Float = 0
    var absementScore: Float = 0
    let wall1 = SKSpriteNode()
    let wall2 = SKSpriteNode()
    let wall3 = SKSpriteNode()
    let player = SKSpriteNode(imageNamed: "pacmanPlayerOpen")
    var playerRelativeYPosition: CGFloat = 50.0
    let playerFrame1 = SKTexture(imageNamed: "pacmanPlayerOpen")
    let playerFrame2 = SKTexture(imageNamed: "pacmanPlayerClose")
    var balancePath: BalancePath?
    var balancePathNode: SKShapeNode = SKShapeNode()
    let balancePathLength: CGFloat = 600.0
    let balancePathAmplification: CGFloat = 0.8
    
    var engine: AudioEngine?
    
    override func didMove(to view: SKView) {
        
        // background setup
        let bounds:CGSize = frame.size
        backgroundColor = SKColor.black
        background.zPosition = -10.0
        background.scale(to: frame.size)
        
        // absementLabel setup
        absementLabel.zPosition = 1
        absementLabel.fontName = "AvenirNextCondensed-Heavy"
        absementLabel.fontSize = 50.0
        absementLabel.fontColor = SKColor.white
        var scoreText = String(absement)
        absementLabel.text = scoreText
        absementLabel.horizontalAlignmentMode = .right
        absementLabel.position = CGPoint(x: bounds.width - absementLabel.frame.size.width / 2 + 10.0,
                                         y: bounds.height - absementLabel.frame.size.height - 15.0)
        
        // absementScoreLabel setup
        absementScoreLabel.zPosition = 1
        absementScoreLabel.fontName = "AvenirNextCondensed-Heavy"
        absementScoreLabel.fontSize = 50.0
        absementScoreLabel.fontColor = SKColor.red
        scoreText = String(absement)
        absementScoreLabel.text = scoreText
        absementScoreLabel.horizontalAlignmentMode = .right
        absementScoreLabel.position = CGPoint(x: bounds.width - absementScoreLabel.frame.size.width / 2 + 10.0,
                                              y: absementLabel.frame.minY - absementScoreLabel.frame.size.height - 10.0 )
        
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
        addChild(absementLabel)
        addChild(absementScoreLabel)
        addChild(wall1)
        addChild(wall2)
        addChild(wall3)
        addChild(player)
        
        // initiate balance path
        balancePath = BalancePath(origin: CGPoint(x: bounds.width / 2, y: 100.0),
                                  length: balancePathLength,
                                  bounds: bounds,
                                  distanceToBottom: playerRelativeYPosition)
        if let balancePath = balancePath {
            balancePathNode.zPosition = 0
            balancePathNode.path = balancePath.path
            balancePathNode.lineWidth = 5.0
            balancePathNode.strokeColor = UIColor.white
            balancePathNode.physicsBody = SKPhysicsBody(edgeChainFrom: balancePath.path)
            balancePathNode.physicsBody?.isDynamic = false
            addChild(balancePathNode)
        }
        
        // motion setup
        motionManager.startAccelerometerUpdates()
        
        // audio setup
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
    
    private func updateAbsement(_ absement: Float) {
        let convertedAbsement: Float = absement / Float(frame.width)
        self.absement = convertedAbsement
        var scoreText = String(format: "%.1f", self.absement)
        absementLabel.text = scoreText
        self.absementScore += convertedAbsement
        scoreText = String(format: "%.1f", self.absementScore)
        absementScoreLabel.text = scoreText
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
                balancePath.appendBalancePathWithRandomSegment(length: balancePathLength, amplification: balancePathAmplification)
            }

            balancePathNode.path = balancePath.path
        }
        updateAbsement(Float(xDifference))
        self.engine!.modifyPitch(with: -Float(xDifference * 2))
    }
}