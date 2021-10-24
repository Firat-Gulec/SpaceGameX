//
//  Player.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 8.05.2020.
//  Copyright © 2020 Firat Gulec. All rights reserved.
//

import SpriteKit

class Player1: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "Spaceship_all")
        super.init(texture: texture, color: .clear, size: CGSize(width: 120, height: 170))
        
        zPosition = 1.0
        setScale(0.7)
    }
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
