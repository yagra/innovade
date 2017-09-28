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
    private let keyTimes = [0, 0.1, 0.5, 0.6, 0.8, 0.99, 1] as [NSNumber]
    private let settings = InnovadeSettings.sharedSettings

    func animate(layer: CALayer, size: CGSize) {
        _ = CALayer().handle {
            $0.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            $0.backgroundColor = settings.BackgroundColor.cgColor
            $0.cornerRadius = 10.0
            layer.addSublayer($0)
        }
        drawPourLayer(layer: layer, width: size.width)
        drawDrinkLayer(layer: layer, width: size.width)
        drawGlassLayer(layer: layer, width: size.width)
    }

    private func drawPourLayer(layer: CALayer, width: CGFloat) {
        let glassHeight = width / 2
        let pourLayer = CALayer()
        layer.addSublayer(pourLayer)
        let frame = CGRect(x: 0, y: 0, width: width, height: width)

        for i in 0...4 {
            let _ = CAShapeLayer().handle {
                $0.frame = frame
                $0.lineWidth = width / 100
                $0.strokeColor = settings.Color.cgColor
                let path = UIBezierPath()
                let x = width / 1.8 + CGFloat(i) * width / 80
                path.move(to: CGPoint(x: x, y: width / 50))
                path.addLine(to: CGPoint(x: x, y: width - glassHeight * 0.25))
                $0.path = path.cgPath
                pourLayer.addSublayer($0)
            }
        }

        _ = CAKeyframeAnimation(keyPath: "transform.scale.y").handle {
            $0.keyTimes = keyTimes
            $0.values = [0.0, 1.0, 0.8, 0.0, 0.0, 0.0, 0.0]
            $0.duration = duration
            $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            $0.repeatCount = HUGE
            $0.isRemovedOnCompletion = false
            pourLayer.add($0, forKey: "pour")
        }
    }

    private func drawDrinkLayer(layer: CALayer, width: CGFloat) {
        let glassHeight = width / 2
        let liquidLayer = CAShapeLayer().handle {
            $0.frame = CGRect(x: 0, y: 0, width: width, height: width)
            $0.lineWidth = width / 100
            $0.strokeColor = settings.Color.cgColor
            let path = UIBezierPath()
            path.move(to: CGPoint(x: width / 3, y: width / 10))
            path.addLine(to: CGPoint(x: width / 3 + width / 5, y: width - glassHeight * 0.25))
            path.addLine(to: CGPoint(x: width / 3 + width / 5 + width / 20, y: width - glassHeight * 0.25))
            path.addLine(to: CGPoint(x: width / 3 + width / 20, y: width / 10))
            $0.path = path.cgPath
            layer.addSublayer($0)
        }

        _ = CAKeyframeAnimation(keyPath: "fillColor").handle {
            $0.keyTimes = keyTimes
            let clear = UIColor.clear.cgColor
            let fill = UIColor.black.withAlphaComponent(0.9).cgColor
            $0.values = [clear, clear, clear, fill, fill, fill, clear]
            $0.duration = duration
            $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            $0.repeatCount = HUGE
            $0.isRemovedOnCompletion = false
            liquidLayer.add($0, forKey: "color")
        }
    }

    private func drawGlassLayer(layer: CALayer, width: CGFloat) {
        let glassHeight = width / 2
        let glassWidth = width / 3
        let frame = CGRect(x: 0, y: width - glassHeight * 1.2, width: width, height: glassHeight)

        let glassLayer = CAShapeLayer().handle {
            $0.frame = frame
            $0.lineWidth = glassWidth / 10
            $0.strokeColor = settings.Color.cgColor
            $0.fillColor = settings.Color.cgColor
            let path = UIBezierPath()
            path.move(to: CGPoint(x: (width - glassWidth) / 2, y: 0))
            path.addLine(to: CGPoint(x: (width - glassWidth) / 2, y: glassHeight))
            path.addLine(to: CGPoint(x: (width + glassWidth) / 2, y: glassHeight))
            path.addLine(to: CGPoint(x: (width + glassWidth) / 2, y: 0))
            $0.path = path.cgPath
            layer.addSublayer($0)
        }

        let liquidLayer = CAShapeLayer().handle {
            $0.frame = frame
            $0.path = UIBezierPath(rect: CGRect(x: (width - glassWidth) / 2, y: 0,
                                                width: glassWidth, height: glassHeight)).cgPath
            glassLayer.addSublayer($0)
        }

        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y").handle {
            $0.values = [0.0, 0.0, 1.0, 1.0, 0.0, 0.0]
        }
        let positionAnimation = CAKeyframeAnimation(keyPath: "position.y").handle {
            $0.values = [glassHeight, glassHeight, glassHeight / 2, glassHeight / 2, glassHeight, glassHeight]
        }
        _ = CAAnimationGroup().handle {
            $0.animations = [scaleAnimation, positionAnimation].map {
                $0.duration = duration
                $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
                $0.keyTimes = keyTimes
                return $0
            }
            $0.duration = duration
            $0.repeatCount = HUGE
            $0.isRemovedOnCompletion = false
            liquidLayer.add($0, forKey: "liquid")
        }
    }
}
