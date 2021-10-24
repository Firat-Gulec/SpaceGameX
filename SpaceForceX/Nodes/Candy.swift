//
//  Candy.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 15.05.2021.
//  Copyright © 2021 Firat Gulec. All rights reserved.
//


import SpriteKit

enum CandySettings: Int {
    case small = 0, medium, large
}

class Candy : SKSpriteNode {
    var healty: Int = 5
    var type: CandySettings = .small
    class func createCandySmall() -> Candy {
        let candy = setupCandies("candy1", healty: 2, type: .small)
        candy.size = CGSize(width: 50, height: 60)
        return candy
    }
    class func createCandySmall2() -> Candy {
        let candy = setupCandies("candy4", healty: 2, type: .small)
        candy.size = CGSize(width: 50, height: 60)
        return candy
    }
    
    class func createCandyMedium() -> Candy {
        let candy = setupCandies("candy2", healty: 4, type: .medium)
        candy.size = CGSize(width: 100, height: 110)
        return candy
    }
    class func createCandyMedium2() -> Candy {
        let candy = setupCandies("candy5", healty: 4, type: .medium)
        candy.size = CGSize(width: 100, height: 110)
        return candy
    }
    
    class func createCandyLarge() -> Candy {
        let candy = setupCandies("candy3", healty: 7, type: .large, scale: 0.9 )
        candy.size = CGSize(width: 200, height: 200)
        return candy
    }
    class func createCandyLarge2() -> Candy {
        let candy = setupCandies("candy6", healty: 7, type: .large, scale: 0.9 )
        candy.size = CGSize(width: 200, height: 200)
        return candy
    }
    
    class func setupCandies(_ imgNamed: String, healty: Int, type: CandySettings, scale: CGFloat = 1.0) -> Candy {
        let sprite = Candy(imageNamed: imgNamed)
        sprite.type = type
        sprite.healty = healty
        sprite.setScale(scale)
        sprite.zPosition = 5.0
        return sprite
    }
}
