//
//  RamenAnimation.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/10.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation

class RamenAnimation: InnovadeAnimationType {
    private let settings = InnovadeSettings.sharedSettings

    func animate(layer: CALayer, size: CGSize) {
        _ = CALayer().$ {
            $0.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            $0.backgroundColor = settings.BackgroundColor.cgColor
            $0.cornerRadius = 10.0
            layer.addSublayer($0)
        }
        drawNoodlesLayer(layer: layer, width: size.width)
        drawBowlLayer(layer: layer, width: size.width)
    }

    private func drawNoodlesLayer(layer: CALayer, width: CGFloat) {
        let height = width / 2
        let frame = CGRect(x: 0, y: width / 2 - height, width: width, height: height)
        let topLayer = CALayer()
        topLayer.frame = frame
        for i in 0...2 {
            _ = CAShapeLayer().$ {
                $0.frame = frame
                $0.strokeColor = settings.Color.cgColor
                $0.lineWidth = width / 30
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
                $0.path = path.cgPath
                topLayer.addSublayer($0)
            }
        }
        for i in 0...1 {
            _ = CAShapeLayer().$ {
                $0.frame = frame
                $0.strokeColor = settings.Color.cgColor
                $0.lineWidth = width / 30
                let path = UIBezierPath()
                path.move(to: CGPoint(x: width * 0.3, y: CGFloat(i) * height / 10))
                path.addLine(to: CGPoint(x: width * 0.9, y: CGFloat(i) * height / 10))
                path.close()
                $0.path = path.cgPath
                topLayer.addSublayer($0)
            }
        }

        _ = CAKeyframeAnimation(keyPath: "position.y").$ {
            $0.duration = 1.0
            $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            $0.keyTimes = [0, 0.5, 1]
            $0.values = [width / 1.8, width / 2.8, width / 1.8]
            $0.repeatCount = HUGE
            $0.isRemovedOnCompletion = false
            topLayer.add($0, forKey: "moveAnimation")
        }

        layer.addSublayer(topLayer)
    }

    private func drawBowlLayer(layer: CALayer, width: CGFloat) {
        let height = width / 2.4
        let unitWidth = width / 8
        let frame = CGRect(x: 0, y: width - height, width: width, height: height)

        _ = CAShapeLayer().$ {
            $0.frame = frame
            $0.fillColor = settings.Color.cgColor
            let path = UIBezierPath()
            path.move(to: CGPoint(x: unitWidth, y: 0))
            path.addCurve(to: CGPoint(x: width - unitWidth, y: 0),
                          controlPoint1: CGPoint(x: unitWidth, y: height),
                          controlPoint2: CGPoint(x: width - unitWidth, y: height))
            path.close()
            $0.path = path.cgPath
            layer.addSublayer($0)
        }

        _ = CAShapeLayer().$ {
            $0.frame = frame
            $0.fillColor = settings.Color.cgColor
            $0.path = UIBezierPath(rect:CGRect(x: width / 2 - unitWidth, y: height - unitWidth * 1.4,
                                                      width: unitWidth * 2, height: unitWidth)).cgPath
            layer.addSublayer($0)
        }
    }
}
