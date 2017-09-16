//
//  InnovadeAnimationType.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/10.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation

protocol InnovadeAnimationType {
    func animate(layer: CALayer, size: CGSize)
}

public enum InnovadeAnimation {
    case Ramen
    case Drink

    func animation() -> InnovadeAnimationType {
        switch self {
        case .Ramen:
            return RamenAnimation()
        case .Drink:
            return DrinkAnimation()
        }
    }
}
