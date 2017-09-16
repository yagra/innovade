//
//  InnovadeMessageType.swift
//  innovade
//
//  Created by Ryosuke Hayashi on 2017/09/16.
//  Copyright © 2017年 yagra. All rights reserved.
//

import Foundation

public protocol InnovadeMessageType {
    func message(layer: CALayer, size: CGSize, message: String)
}
