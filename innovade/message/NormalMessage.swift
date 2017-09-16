//
//  NormalMessage.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/16.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation

class NormalMessage: InnovadeMessageType {
    private let settings = InnovadeSettings.sharedSettings

    func message(layer: CALayer, size: CGSize, message: String) {
        _ = CALayer().$ {
            $0.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            $0.backgroundColor = settings.BackgroundColor.cgColor
            $0.cornerRadius = 10.0
            layer.addSublayer($0)
        }

        _ = CATextLayer().$ {
            $0.string = message
            $0.fontSize = settings.FontSize
            $0.foregroundColor = settings.TextColor.cgColor
            $0.alignmentMode = kCAAlignmentCenter
            $0.contentsScale = UIScreen.main.scale

            let textSize = message.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: settings.FontSize)])

            $0.frame = CGRect(x: 0, y: (size.height - textSize.height) / 2,
                              width: size.width, height: textSize.height * 2)
            layer.addSublayer($0)
        }
    }
}
