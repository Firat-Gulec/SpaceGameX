//
//  Fruit.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 28.05.2021.
//  Copyright © 2021 Firat Gulec. All rights reserved.
//


import SpriteKit

enum FruitSettings: Int {
    case small = 0, medium, large
}

class Fruit : SKSpriteNode {
    var healty: Int = 5
    var type: FruitSettings = .small
    class func createFruitSmall() -> Fruit {
        let fruit = setupFruits("fruit4", healty: 2, type: .small)
        fruit.size = CGSize(width: 50, height: 60)
        return fruit
    }
    class func createFruitSmall2() -> Fruit {
        let fruit = setupFruits("fruit5", healty: 2, type: .small)
        fruit.size = CGSize(width: 60, height: 70)
        return fruit
    }
    class func createFruitMedium() -> Fruit {
        let fruit = setupFruits("fruit2", healty: 3, type: .medium)
        fruit.size = CGSize(width: 60, height: 70)
        return fruit
    }
    class func createFruitMedium2() -> Fruit {
        let fruit = setupFruits("fruit6", healty: 3, type: .medium)
        fruit.size = CGSize(width: 60, height: 70)
        return fruit
    }
    class func createFruitLarge() -> Fruit {
        let fruit = setupFruits("fruit3", healty: 5, type: .large, scale: 0.9 )
        fruit.size = CGSize(width: 80, height: 80)
        return fruit
    }
    class func createFruitLarge2() -> Fruit {
        let fruit = setupFruits("fruit1", healty: 8, type: .large, scale: 0.9 )
        fruit.size = CGSize(width: 200, height: 200)
        return fruit
    }
    
    class func setupFruits(_ imgNamed: String, healty: Int, type: FruitSettings, scale: CGFloat = 1.0) -> Fruit {
        let sprite = Fruit(imageNamed: imgNamed)
        sprite.type = type
        sprite.healty = healty
        sprite.setScale(scale)
        sprite.zPosition = 5.0
        return sprite
    }
}
