//
//  RamenAnimation.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/10.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation

class RamenAnimation: InnovadeAnimationType {

    func animate(layer: CALayer, size: CGSize) {
        let backgroundLayer = CALayer()
        
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        backgroundLayer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        backgroundLayer.cornerRadius = 10.0
        layer.addSublayer(backgroundLayer)

        drawTopLayer(layer: layer, width: size.width)
        drawBottomLayer(layer: layer, size: size)
    }

    private func drawTopLayer(layer: CALayer, width: CGFloat) {
        let height = width / 2
        let frame = CGRect(x: 0, y: width / 2 - height, width: width, height: height)

        let topLayer = CALayer()
        topLayer.frame = frame

        for i in 0...2 {
            let layer = CAShapeLayer()
            layer.frame = frame
            layer.strokeColor = UIColor.black.cgColor
            layer.lineWidth = width / 30
            let path = UIBezierPath()
            let x = width * 0.4 + CGFloat(i) * width / 20
            var y = height / 12 as CGFloat
            path.move(to: CGPoint(x: x, y: y))
            let waveCount = 5
            let dy = height / CGFloat(waveCount)

            for _ in 0..<waveCount {
                path.addQuadCurve(to: CGPoint(x: x, y: y + dy / 2),
                                  controlPoint: CGPoint(x: x + width / 50, y: y + dy / 4))
                path.addQuadCurve(to: CGPoint(x: x, y: y + dy),
                                  controlPoint: CGPoint(x: x - width / 50, y: y + dy / 4 * 3))
                y += dy
            }
            layer.path = path.cgPath
            topLayer.addSublayer(layer)
        }
        for i in 0...1 {
            let layer = CAShapeLayer()
            layer.frame = frame
            layer.strokeColor = UIColor.black.cgColor
            layer.lineWidth = width / 30
            let path = UIBezierPath()
            path.move(to: CGPoint(x: width * 0.3, y: CGFloat(i) * height / 10))
            path.addLine(to: CGPoint(x: width * 0.9, y: CGFloat(i) * height / 10))
            path.close()
            layer.path = path.cgPath
            topLayer.addSublayer(layer)
        }

        let moveAnimation = CAKeyframeAnimation(keyPath: "position.y")
        moveAnimation.duration = 1.0
        moveAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        moveAnimation.keyTimes = [0, 0.5, 1]
        moveAnimation.values = [width / 1.8, width / 2.8, width / 1.8]
        moveAnimation.repeatCount = HUGE
        moveAnimation.isRemovedOnCompletion = false
        topLayer.add(moveAnimation, forKey: "moveAnimation")
        layer.addSublayer(topLayer)
    }

    private func drawBottomLayer(layer: CALayer, size: CGSize) {
        let width = size.width
        let height = width / 2.4
        let unitWidth = size.width / 8
        let frame = CGRect(x: 0, y: size.height - height, width: width, height: height)

        let semicircleLayer = CAShapeLayer()
        semicircleLayer.frame = frame
        semicircleLayer.fillColor = UIColor.black.cgColor
        let path = UIBezierPath()
        path.move(to: CGPoint(x: unitWidth, y: 0))
        path.addCurve(to: CGPoint(x: width - unitWidth, y: 0),
                      controlPoint1: CGPoint(x: unitWidth, y: height),
                      controlPoint2: CGPoint(x: width - unitWidth, y: height))
        path.close()
        semicircleLayer.path = path.cgPath
        layer.addSublayer(semicircleLayer)

        let rectLayer = CAShapeLayer()
        rectLayer.frame = frame
        rectLayer.fillColor = UIColor.black.cgColor
        rectLayer.path = UIBezierPath(rect:CGRect(x: width / 2 - unitWidth, y: height - unitWidth * 1.4,
                                                  width: unitWidth * 2, height: unitWidth)).cgPath
        layer.addSublayer(rectLayer)
    }
}
