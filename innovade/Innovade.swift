//
//  Innovade.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/10.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation


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
    public var TextColor: UIColor = UIColor.black
    public var FontSize: CGFloat = 20.0

    private init() {}

    public func handle(_ handler: (InnovadeSettings) -> Void) -> Self {
        handler(self)
        return self
    }
}

extension NSCoding {
    func handle(_ handler: (Self) -> Void) -> Self {
        handler(self)
        return self
    }
}
