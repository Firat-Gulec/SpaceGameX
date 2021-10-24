//
//  CGFloat+Exts.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 8.05.2020.
//  Copyright © 2020 Firat Gulec. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    
    static func random(min: CGFloat, max: CGFloat) ->CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
}
