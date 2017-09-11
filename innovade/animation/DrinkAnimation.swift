//
//  DrinkAnimation.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/11.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation

class DrinkAnimation: InnovadeAnimationType {
    private let duration = CFTimeInterval(5)
    private let keyTimes = [0, 0.1, 0.5, 0.6, 0.8, 1] as [NSNumber]

    func animate(layer: CALayer, size: CGSize) {
        let backgroundLayer = CALayer()

        backgroundLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        backgroundLayer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        backgroundLayer.cornerRadius = 10.0
        layer.addSublayer(backgroundLayer)

        drawPourLayer(layer: layer, width: size.width)
        drawDrinkLayer(layer: layer, width: size.width)
        drawGlassLayer(layer: layer, width: size.width)
    }

    private func drawPourLayer(layer: CALayer, width: CGFloat) {
        let glassHeight = width / 2
        let pourLayer = CALayer()
        let frame = CGRect(x: 0, y: 0, width: width, height: width)

        for i in 0...4 {
            let layer = CAShapeLayer()
            layer.frame = frame
            layer.lineWidth = width / 100
            layer.strokeColor = UIColor.black.cgColor
            let path = UIBezierPath()
            let x = width / 2 + CGFloat(i) * width / 80
            path.move(to: CGPoint(x: x, y: width / 50))
            path.addLine(to: CGPoint(x: x, y: width - glassHeight * 0.25))
            layer.path = path.cgPath
            pourLayer.addSublayer(layer)
        }

        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        scaleAnimation.keyTimes = keyTimes
        scaleAnimation.values = [0.0, 1.0, 0.8, 0.0, 0.0, 0.0]
        scaleAnimation.duration = duration
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        scaleAnimation.repeatCount = HUGE
        scaleAnimation.isRemovedOnCompletion = false
        pourLayer.add(scaleAnimation, forKey: "pour")
        layer.addSublayer(pourLayer)
    }

    private func drawDrinkLayer(layer: CALayer, width: CGFloat) {
        let glassHeight = width / 2
        let frame = CGRect(x: 0, y: 0, width: width, height: width)

        let strawLayer = CAShapeLayer()
        strawLayer.frame = frame
        strawLayer.lineWidth = width / 100
        strawLayer.strokeColor = UIColor.black.cgColor
        let path = UIBezierPath()
        path.move(to: CGPoint(x: width / 3, y: width / 10))
        path.addLine(to: CGPoint(x: width / 3 + width / 5, y: width - glassHeight * 0.25))
        path.addLine(to: CGPoint(x: width / 3 + width / 5 + width / 20, y: width - glassHeight * 0.25))
        path.addLine(to: CGPoint(x: width / 3 + width / 20, y: width / 10))
        strawLayer.path = path.cgPath

        let colorAnimation = CAKeyframeAnimation(keyPath: "fillColor")
        colorAnimation.keyTimes = keyTimes
        let clear = UIColor.clear.cgColor
        let fill = UIColor.black.withAlphaComponent(0.9).cgColor
        colorAnimation.values = [clear, clear, clear, fill, fill, clear]
        colorAnimation.duration = duration
        colorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        colorAnimation.repeatCount = HUGE
        colorAnimation.isRemovedOnCompletion = false
        strawLayer.add(colorAnimation, forKey: "color")

        layer.addSublayer(strawLayer)
    }

    private func drawGlassLayer(layer: CALayer, width: CGFloat) {
        let glassHeight = width / 2
        let glassWidth = width / 3
        let glassLayer = CAShapeLayer()
        let frame = CGRect(x: 0, y: width - glassHeight * 1.2, width: width, height: glassHeight)

        glassLayer.frame = frame
        glassLayer.lineWidth = glassWidth / 10
        glassLayer.strokeColor = UIColor.black.cgColor
        glassLayer.fillColor = UIColor.clear.cgColor
        let path = UIBezierPath()
        path.move(to: CGPoint(x: (width - glassWidth) / 2, y: 0))
        path.addLine(to: CGPoint(x: (width - glassWidth) / 2, y: glassHeight))
        path.addLine(to: CGPoint(x: (width + glassWidth) / 2, y: glassHeight))
        path.addLine(to: CGPoint(x: (width + glassWidth) / 2, y: 0))
        glassLayer.path = path.cgPath

        let liquidLayer = CAShapeLayer()
        liquidLayer.frame = frame
        liquidLayer.path = UIBezierPath(rect: CGRect(x: (width - glassWidth) / 2, y: 0,
                                                    width: glassWidth, height: glassHeight)).cgPath

        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        scaleAnimation.values = [0.0, 0.0, 1.0, 1.0, 0.0]
        let positionAnimation = CAKeyframeAnimation(keyPath: "position.y")
        positionAnimation.values = [glassHeight, glassHeight, glassHeight / 2, glassHeight / 2, glassHeight]

        let animations = CAAnimationGroup()
        animations.animations = [scaleAnimation, positionAnimation].map {
            $0.duration = duration
            $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            $0.keyTimes = keyTimes
            return $0
        }

        animations.duration = duration
        animations.repeatCount = HUGE
        animations.isRemovedOnCompletion = false
        liquidLayer.add(animations, forKey: "liquid")
        glassLayer.addSublayer(liquidLayer)
        layer.addSublayer(glassLayer)
    }
}
