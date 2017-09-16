//
//  SuccessMessage.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/16.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation

class SuccessMessage: InnovadeMessageType {
    private let settings = InnovadeSettings.sharedSettings

    func show(layer: CALayer, size: CGSize, message: String) {
        let width = size.width
        _ = CALayer().$ {
            $0.frame = CGRect(x: 0, y: 0, width: width, height: size.height)
            $0.backgroundColor = settings.BackgroundColor.cgColor
            $0.cornerRadius = 10.0
            layer.addSublayer($0)
        }

        _ = CAShapeLayer().$ {
            $0.frame = CGRect(x: 0, y: 0, width: width, height: size.height)
            $0.fillColor = settings.Color.cgColor
            $0.path = UIBezierPath(ovalIn:
                CGRect(x: width * 0.27, y: width * 0.17,
                       width: width * 0.46, height: width * 0.46)
                ).cgPath
            let mask = CAShapeLayer()
            mask.frame = CGRect(x: 0, y: 0, width: width, height: size.height)
            let maskPath = UIBezierPath()
            maskPath.move(to: CGPoint(x: width * 0.35, y: width * 0.41))
            maskPath.addLine(to: CGPoint(x: width * 0.47, y: width * 0.53))
            maskPath.addLine(to: CGPoint(x: width * 0.66, y: width * 0.36))
            maskPath.addLine(to: CGPoint(x: width * 0.62, y: width * 0.32))
            maskPath.addLine(to: CGPoint(x: width * 0.47, y: width * 0.45))
            maskPath.addLine(to: CGPoint(x: width * 0.39, y: width * 0.37))
            maskPath.close()
            maskPath.append(UIBezierPath(rect: $0.bounds))
            mask.path = maskPath.cgPath
            $0.mask = mask
            layer.addSublayer($0)
        }

        _ = CATextLayer().$ {
            $0.string = message
            $0.fontSize = settings.FontSize
            $0.foregroundColor = settings.TextColor.cgColor
            $0.alignmentMode = kCAAlignmentCenter
            $0.contentsScale = UIScreen.main.scale

            $0.frame = CGRect(x: 0, y: size.height * 0.73,
                              width: size.width, height: size.height * 0.25)
            layer.addSublayer($0)
        }
    }
}
