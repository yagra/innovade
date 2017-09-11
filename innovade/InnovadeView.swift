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
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func start() {
        isHidden = false
        isAnimating = true
        layer.speed = 1
        animation.animate(layer: layer, size: frame.size)
    }

    public func stop() {
        isHidden = true
        isAnimating = false
        layer.sublayers?.removeAll()
    }
}