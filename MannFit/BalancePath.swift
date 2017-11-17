//
//  BalancePath.swift
//  MannFit
//
//  Created by Daniel Till on 11/16/17.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit

class BalancePath: NSObject {

    let origin: CGPoint
    var length: CGFloat
    var pathPoints: [CGPoint]
    var path: CGMutablePath
    let bounds: CGSize
    let amplification: CGFloat

    init(origin: CGPoint, length: CGFloat, bounds: CGSize, amplification: CGFloat) {
        self.origin = origin
        self.length = length
        self.bounds = bounds
        self.amplification = amplification
        self.pathPoints = [origin]
        self.path = CGMutablePath()
        path.move(to: origin)
        super.init()
        appendArcPath(left: true)
    }
    
    func playerInPath(playerYPosition: CGFloat) -> Bool {
        guard let first = pathPoints.first else {
            return false
        }
        guard let last = pathPoints.last else {
            return false
        }
        return playerYPosition >= first.y && playerYPosition <= last.y
    }
    
    func differenceFromPathPoint(_ point: CGPoint) -> CGFloat {
        let index = pathPoints.index {
            $0.y == point.y
        }
        if let index = index {
            let pathPoint = pathPoints[index]
            return abs(pathPoint.x - point.x)
        } else {
            return 0.0
        }
    }
    
    private func appendRandomPath() {
        
    }
    
    private func appendStraightPath() {
        for y in 0...Int(length - 1) {
            let newPoint = CGPoint(x: origin.x, y: origin.y + CGFloat(y))
            path.addLine(to: newPoint)
            pathPoints.append(newPoint)
        }
    }
    
    private func appendArcPath(left: Bool) {
        let angleValue = left ? -CGFloat.pi : CGFloat.pi
        for y in 0...Int(length - 1) {
            let x = origin.x + sin(CGFloat(y) * angleValue / length) * bounds.width / 2 * amplification
            let newPoint = CGPoint(x: x, y: origin.y + CGFloat(y))
            path.addLine(to: newPoint)
            pathPoints.append(newPoint)
        }
    }
}
