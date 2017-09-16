//
//  InnovadeMessageType.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/16.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation

public protocol InnovadeMessageType {
    func show(layer: CALayer, size: CGSize, message: String)
}

public enum InnovadeMessage {
    case Normal
    case Success

    func message() -> InnovadeMessageType {
        switch self {
        case .Normal:
            return NormalMessage()
        case .Success:
            return SuccessMessage()
        }
    }
}
