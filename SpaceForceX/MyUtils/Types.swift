//
//  Types.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 9.05.2020.
//  Copyright © 2020 Firat Gulec. All rights reserved.
//

import Foundation

struct physicsCategory {
    static let None:                UInt32 = 0      //0
    static let Player:              UInt32 = 0b1    //1
    static let Enemy:               UInt32 = 0b10   //2
    static let Candy:               UInt32 = 0b10   //2
    static let Fruit:               UInt32 = 0b10   //2
    static let Bullet:              UInt32 = 0b100  //4
}
