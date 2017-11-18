//
//  BalancePath.swift
//  MannFit
//
//  Created by Daniel Till on 11/16/17.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//
import UIKit

class BalancePath: NSObject {
    
    enum LastPathSegment: Int {
        case undefined = 0
        case straight = 1
        case leftArc = 2
        case rightArc = 3
    }
    
    let startPoint: CGPoint
    var endPoint: CGPoint
    // specifices the last part of the path
    var endPathSegment: LastPathSegment
    var totalLength: CGFloat
    var pathPoints: [CGPoint]
    var path: CGMutablePath
    let bounds: CGSize
    var distanceToBottom: CGFloat
    
    init(origin: CGPoint, length: CGFloat, bounds: CGSize, distanceToBottom: CGFloat) {
        self.startPoint = origin
        self.endPoint = origin
        self.endPathSegment = .undefined
        self.totalLength = 0.0
        self.bounds = bounds
        self.pathPoints = [origin]
        self.path = CGMutablePath()
        self.distanceToBottom = distanceToBottom
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
            if point.y - first.y > self.distanceToBottom {
                pathPoints.removeFirst()
                recreatePath()
            }
            return abs(pathPoint.x - point.x)
        } else {
            return 0.0
        }
    }
    
    private func recreatePath() {
        path = CGMutablePath()
        for (index, point) in pathPoints.enumerated() {
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
    }
    
    func appendBalancePathWithRandomSegment(length: CGFloat, amplification: CGFloat) {
        let randomPathIndex = Int(arc4random_uniform(2))
        let randomArcIndex = Int(arc4random_uniform(2))
        
        switch endPathSegment {
        case .straight:
            if randomPathIndex == 0 {
                appendStraightPathSegment(length: length)
            } else if randomPathIndex == 1 {
                appendArcPathSegment(length: length, amplification: amplification, left: randomArcIndex == 0)
            }
            break
        case .leftArc:
            if randomPathIndex == 0 {
                appendStraightPathSegment(length: length)
            } else if randomPathIndex == 1 {
                appendArcPathSegment(length: length, amplification: amplification, left: true)
            }
            break
        case .rightArc:
            if randomPathIndex == 0 {
                appendStraightPathSegment(length: length)
            } else if randomPathIndex == 1 {
                appendArcPathSegment(length: length, amplification: amplification, left: false)
            }
            break
        default: break
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
        endPathSegment = .straight
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
        endPathSegment = left ? .leftArc : .rightArc
    }
}

