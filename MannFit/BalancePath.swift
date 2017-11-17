//
//  BalancePath.swift
//  MannFit
//
//  Created by Daniel Till on 11/16/17.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit

class BalancePath: NSObject {

    let startPoint: CGPoint
    var endPoint: CGPoint
    // specifices the last part of the path
    // 0 - undefined 1 - striaght 2 - arc, left 3 - arc, right
    var endPathSegment: Int
    var totalLength: CGFloat
    var pathPoints: [CGPoint]
    var path: CGMutablePath
    let bounds: CGSize

    init(origin: CGPoint, length: CGFloat, bounds: CGSize) {
        self.startPoint = origin
        self.endPoint = origin
        self.endPathSegment = 0
        self.totalLength = 0.0
        self.bounds = bounds
        self.pathPoints = [origin]
        self.path = CGMutablePath()
        path.move(to: origin)
        super.init()
        appendStraightPathSegment(length: length)
    }
    
    func differenceFromPathPoint(_ point: CGPoint) -> CGFloat {
        guard let first = pathPoints.first else {
            return 0.0
        }
        guard let last = pathPoints.last else {
            return 0.0
        }
        if point.y <= first.y && point.y >= last.y {
            return 0.0
        }
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
    
    func appendBalancePathWithRandomSegment(length: CGFloat, amplification: CGFloat) {
        let randomPathIndex = Int(arc4random_uniform(2))
        let randomArcIndex = Int(arc4random_uniform(2))
      
        if endPathSegment == 1 {
            if randomPathIndex == 0 {
                appendStraightPathSegment(length: length)
            } else if randomPathIndex == 1 {
                appendArcPathSegment(length: length, amplification: amplification, left: randomArcIndex == 0)
            }
        } else if endPathSegment == 2 {
            if randomPathIndex == 0 {
                appendStraightPathSegment(length: length)
            } else if randomPathIndex == 1 {
                appendArcPathSegment(length: length, amplification: amplification, left: true)
            }
        } else if endPathSegment == 3 {
            if randomPathIndex == 0 {
                appendStraightPathSegment(length: length)
            } else if randomPathIndex == 1 {
                appendArcPathSegment(length: length, amplification: amplification, left: false)
            }
        }
    }
    
    func appendStraightPathSegment(length: CGFloat) {
        for y in 1...Int(length) {
            let newPoint = CGPoint(x: endPoint.x, y: endPoint.y + CGFloat(y))
            path.addLine(to: newPoint)
            pathPoints.append(newPoint)
        }
        totalLength += length
        if let lastPoint = pathPoints.last {
            endPoint = lastPoint
        }
        endPathSegment = 1
    }
    
    func appendArcPathSegment(length: CGFloat, amplification: CGFloat, left: Bool) {
        let angleValue = left ? -CGFloat.pi : CGFloat.pi
        for y in 1...Int(length) {
            let x = endPoint.x + sin(CGFloat(y) * 2 * angleValue / length) * bounds.width / 2 * amplification
            let newPoint = CGPoint(x: x, y: endPoint.y + CGFloat(y))
            path.addLine(to: newPoint)
            pathPoints.append(newPoint)
        }
        totalLength += length
        if let lastPoint = pathPoints.last {
            endPoint = lastPoint
        }
        endPathSegment = left ? 2 : 3
    }
}
