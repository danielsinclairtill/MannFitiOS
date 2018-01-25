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

struct AccelerometerDataPoint {
    let x: Double
    let y: Double
    let z: Double
}

class TestingGameScene: SKScene {
    private let motionManager = CMMotionManager()
    private let userDefaults: UserDefaults = UserDefaults.standard
    weak var gameOverDelegate: GameOverDelegate?
    
    private var gameActive: Bool = true
    private var recording: Bool = false
    private var recordedData: [AccelerometerDataPoint] = []
    private var recordStartTime: Date?
    private var recordEndTime: Date?
    
    private let background = SKSpriteNode()
    private let xLabel = SKLabelNode()
    private let yLabel = SKLabelNode()
    private let zLabel = SKLabelNode()
    private var x: Double = 0.0
    private var y: Double = 0.0
    private var z: Double = 0.0
    private let menuButton = SKSpriteNode(imageNamed: "menu-icon")
    private let recordButton = SKSpriteNode(imageNamed: "record-icon")
    private let recordMarker = SKSpriteNode(imageNamed: "record-icon")
    private let stopButton = SKSpriteNode(imageNamed: "stop-icon")
    
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
        xLabel.text = String(format: "X: %.3f", x)
        xLabel.horizontalAlignmentMode = .left
        xLabel.position = CGPoint(x: 10.0, y: bounds.height - xLabel.frame.size.height - self.frame.height / 3.0)
        
        // yLabel setup
        yLabel.zPosition = 1
        yLabel.fontName = "AvenirNextCondensed-Heavy"
        yLabel.fontSize = 50.0
        yLabel.fontColor = SKColor.white
        yLabel.text = String(format: "Y: %.3f", y)
        yLabel.horizontalAlignmentMode = .left
        yLabel.position = CGPoint(x: xLabel.position.x,
                                  y: xLabel.frame.minY - yLabel.frame.size.height - 50.0 )
        
        // zLabel setup
        zLabel.zPosition = 1
        zLabel.fontName = "AvenirNextCondensed-Heavy"
        zLabel.fontSize = 50.0
        zLabel.fontColor = SKColor.white
        zLabel.text = String(format: "Z: %.3f", z)
        zLabel.horizontalAlignmentMode = .left
        zLabel.position = CGPoint(x: xLabel.position.x,
                                  y: yLabel.frame.minY - zLabel.frame.size.height - 50.0 )
        
        // menuButton setup
        menuButton.zPosition = 1
        menuButton.size = CGSize(width: 60.0, height: 60.0)
        menuButton.position = CGPoint(x: bounds.width - stopButton.frame.width / 2 - 10.0,
                                      y: bounds.height - menuButton.frame.size.height / 2 - 15.0)
        
        // recordButton setup
        recordButton.zPosition = 1
        recordButton.size = CGSize(width: 150.0, height: 150.0)
        recordButton.position = CGPoint(x: bounds.width / 3.0,
                                        y: recordButton.frame.height / 2.0 + 30.0)
        
        // stopButton setup
        stopButton.zPosition = 1
        stopButton.size = CGSize(width: 150.0, height: 150.0)
        stopButton.position = CGPoint(x: 2.0 * bounds.width / 3.0,
                                      y: recordButton.position.y)
        
        // recordMarker setup
        recordMarker.zPosition = 1
        recordMarker.alpha = 0.3
        recordMarker.size = CGSize(width: 50.0, height: 50.0)
        recordMarker.position = CGPoint(x: menuButton.position.x,
                                      y: menuButton.frame.minY - recordMarker.frame.size.height / 2 - 15.0)
        
        // add nodes
        addChild(background)
        addChild(xLabel)
        addChild(yLabel)
        addChild(zLabel)
        addChild(menuButton)
        addChild(recordButton)
        addChild(recordMarker)
        addChild(stopButton)
        
        // motion setup
        motionManager.startAccelerometerUpdates()
    }
    
    private func updateData(_ dataPoint: AccelerometerDataPoint) {
        self.x = dataPoint.x
        self.y = dataPoint.y
        self.z = dataPoint.z
        xLabel.text = String(format: "X: %.3f", x)
        yLabel.text = String(format: "Y: %.3f", y)
        zLabel.text = String(format: "Z: %.3f", z)
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        // motion update
        if gameActive {
            if let data = motionManager.accelerometerData {
                let x = data.acceleration.x
                let y = data.acceleration.y
                let z = data.acceleration.z
                let accelerometerDataPoint = AccelerometerDataPoint(x: x.rounded(toPlaces: 3),
                                                                    y: y.rounded(toPlaces: 3),
                                                                    z: z.rounded(toPlaces: 3))
                updateData(accelerometerDataPoint)
                if recording {
                    recordedData.append(accelerometerDataPoint)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == menuButton {
                gameOver()
            } else if node == recordButton {
                startRecording()
            } else if node == stopButton {
                stopRecording(saveData: true)
            }
        }
    }
    
    // MARK: - Recording
    private func startRecording() {
        if !recording {
            recordedData = []
            recordStartTime = Date()
            recordMarker.alpha = 1.0
            recording = true
        }
    }
    
    private func stopRecording(saveData: Bool) {
        if recording {
            recording = false
            recordMarker.alpha = 0.3
            if saveData {
                recordEndTime = Date()
                exportData(data: recordedData, startTime: recordStartTime, stopTime: recordEndTime)
            }
            recordedData = []
        }
    }
    
    private func exportData(data: [AccelerometerDataPoint], startTime: Date?, stopTime: Date?) {
        let fileName = "RecordedAccelerometerData.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        var csvText = "RecordedAccelerometerData\n\n"
        
        if let start = startTime, let end = stopTime {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(identifier: "America/New_York")
            formatter.dateStyle = .long
            formatter.timeStyle = .long
            
            let startDate = formatter.string(from: start)
            let endDate = formatter.string(from: end)
            
            csvText.append(String(format:"Start Time: %@\nEnd Time: %@\n\n", startDate, endDate))
        }
        
        for dataPoint in data {
            let newLine = "\(dataPoint.x),\(dataPoint.y),\(dataPoint.z)\n"
            csvText.append(newLine)
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    }
    
    // MARK: - Game over
    @objc private func gameOver() {
        gameActive = false
        stopRecording(saveData: false)
        self.gameOverDelegate?.presentPrompt()
    }
}
