//
//  Enemy.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 8.05.2020.
//  Copyright © 2020 Firat Gulec. All rights reserved.
//

import SpriteKit

enum EnemySettings: Int {
    case small = 0, medium, large
}


class Enemy : SKSpriteNode {
    
    
    
    var healty: Int = 5
    var type: EnemySettings = .small
    class func createEnemySmall() -> Enemy {
        let enemy = setupEnemies("mt_1_", healty: 2, type: .small)
        enemy.size = CGSize(width: 50, height: 60)
        return enemy
    }
    class func createEnemyMedium() -> Enemy {
        let enemy = setupEnemies("mt_2_", healty: 4, type: .medium)
        enemy.size = CGSize(width: 100, height: 110)
        return enemy
    }
    class func createEnemyLarge() -> Enemy {
        let enemy = setupEnemies("mt_3_", healty: 7, type: .large, scale: 0.9 )
        enemy.size = CGSize(width: 200, height: 200)
        return enemy
    }
    
    class func setupEnemies(_ imgNamed: String, healty: Int, type: EnemySettings, scale: CGFloat = 1.0) -> Enemy {
        let sprite = Enemy(imageNamed: imgNamed)
        sprite.type = type
        sprite.healty = healty
        sprite.setScale(scale)
        sprite.zPosition = .pi / 4
        return sprite
    }
}

