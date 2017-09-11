//
//  Innovade.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/10.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation

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


open class Innovade {
    public class func innovade(_ type: InnovadeAnimation, frame: CGRect?=nil) -> InnovadeView {
        let animeFrame = frame ?? {
            let screen = UIScreen.main.bounds
            let width = screen.width / 3
            return CGRect(x: (screen.width - width) / 2, y: (screen.height - width) / 2,
                          width: width, height: width)
        }()
        return InnovadeView(frame: animeFrame, animation: type.animation())
    }
}
