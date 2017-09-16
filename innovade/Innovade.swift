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


open class InnovadeSettings {
    public static let sharedSettings = InnovadeSettings()

    public var BackgroundColor: UIColor = UIColor.white.withAlphaComponent(0.1)
    public var Color: UIColor = UIColor.black.withAlphaComponent(1)

    private init() {}

    public func $(_ handler: (InnovadeSettings) -> Void) -> Self {
        handler(self)
        return self
    }
}

extension NSCoding {
    func $(_ handler: (Self) -> Void) -> Self {
        handler(self)
        return self
    }
}
