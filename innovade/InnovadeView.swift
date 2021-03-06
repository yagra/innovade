//
//  InnovadeViewType.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/10.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation
import UIKit


open class InnovadeView: UIView {
    private(set) public var isAnimating: Bool = false
    private let animation: InnovadeAnimationType

    init(frame: CGRect, animation: InnovadeAnimationType) {
        self.animation = animation
        super.init(frame: frame)
        isHidden = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func start() {
        if isAnimating {
            return
        }
        isHidden = false
        isAnimating = true
        layer.speed = 1
        animation.animate(layer: layer, size: frame.size)
    }

    public func stop() {
        if !isAnimating {
            return
        }
        isHidden = true
        isAnimating = false
        layer.sublayers?.removeAll()
    }

    public func stopWithMessage(displayTime: TimeInterval, text: String, message: InnovadeMessage = .Normal) {
        if !isAnimating {
            return
        }
        layer.sublayers?.removeAll()
        message.message().show(layer: layer, size: frame.size, message: text)
        DispatchQueue.main.asyncAfter(deadline: .now() + displayTime) {
            self.stop()
        }
    }
}
