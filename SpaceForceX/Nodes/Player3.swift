//
//  Player3.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 17.07.2021.
//  Copyright © 2021 Firat Gulec. All rights reserved.
//

import SpriteKit

class Player3: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "Spaceship_one_fruit")
        super.init(texture: texture, color: .clear, size: CGSize(width: 120, height: 170))
        zPosition = 1.0
        setScale(0.7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
