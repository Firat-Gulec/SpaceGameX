//
//  FruitScene.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 28.05.2021.
//  Copyright © 2021 Firat Gulec. All rights reserved.
//

import SpriteKit
import GameplayKit

class FruitScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Properties
    
    
    //Oluşturduğumuz player değişkenini tanımlıyoruz.
    var player = Player3()
    var difficulty = String()
    var livesArray:[SKSpriteNode]!
    
    var engine = SKEmitterNode(fileNamed: "fuse")!
    //ScoreLabel ve score değişkeni
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //Timer
    var gameTimer:Timer!
    
    var fruitCategory:UInt32 = 0x1 << 1
    var bulletCategory:UInt32 = 0x1 << 0
    var playerCategory:UInt32 = 0b10 << 2
    var backgroundImage = String()
    
    //var starfield:SKEmitterNode!
    
    // MARK: -Systems
    
    //Oyun çalıştığında açılması için çalışması için fonksiyonların eklenmesi
    override func didMove(to view: SKView) {
    
        if backgroundImage == "" {
            backgroundImage = "bg_03.png"
        }
        setupNodes()
        createPlayer()
        createFruit()
        spawnFruits()
        createBullet()
        setupPhysics()
        addLives()
        //gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(<#T##@objc method#>), userInfo: nil, repeats: true)
        
        //func yapılacak kısım
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 120, y: self.frame.size.height - 60)
        scoreLabel.zPosition = 7.0
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.color = UIColor.white
        scoreLabel.fontSize = 36
        score = 0
        addChild(scoreLabel)
        
        
        

    }
    
    
    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    //Dokunma Başladığında çağırılmasını istediğimiz func
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        //Dokuma tanımlanması sonrası lokasyonu alınıp Player'ın o noktaya hareketi tanımlanıyor.
        player.run(.move(to: CGPoint(x: location.x, y: location.y + 100), duration: 0.1))
        engine.run(.move(to: CGPoint(x: location.x, y: location.y + 100), duration: 0.1))
    }
    
    //Dokunma devam edip pozisyon değiştirilirken çağırılmasını istediğimiz func
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        //Dokunma devam etmesi tanımlanması sonrası lokasyon alınıp Player'ın pozisyonunun buna göre atanması
        player.position = CGPoint(x: location.x, y: location.y + 100)
        engine.position = CGPoint(x: player.position.x, y: player.position.y - 30 )
    }
    
    //Sürekli ekranda değişmesini istediğimiz kısımları ekleyeceğimiz func
    override func update(_ currentTime: TimeInterval) {
        moveBG()
    }
    
}
 
    // MARK: -Configrations

    extension FruitScene {
        
        func setupNodes() {
          createBG()
        }
    
        //TODO : Background
        func createBG() {
            for i in 0...2 {
                let bg = SKSpriteNode(imageNamed: backgroundImage)
                bg.zPosition = -1.0
                bg.name = "BG"
                //Check it later (Ana Ekran point en altta 0 da olmalı !)
                bg.position = CGPoint(x: frame.width / 2, y: CGFloat(i)*bg.frame.height + frame.height / 2.0)
                addChild(bg)
               }
        }

        func moveBG() {
            enumerateChildNodes(withName: "BG") { (node ,_) in
                let node = node as! SKSpriteNode
                node.position.y -= 4.5
                
                if node.position.y < -self.frame.height {
                    node.position.y += self.frame.height*2.0 + self.frame.height/2.0 + 100
                }
            }
        }
        
        //TODO : Player
        func createPlayer() {
            player.position = CGPoint(x: self.frame.size.width / 2, y: player.size.height / 2 + 20)
            
            player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
            player.physicsBody?.isDynamic = true
            player.physicsBody?.categoryBitMask = playerCategory
            player.physicsBody?.contactTestBitMask = fruitCategory
            player.physicsBody?.collisionBitMask = 0
            engine.position = CGPoint(x: self.frame.size.width / 2, y: player.size.height / 2 - 30 )
            addChild(engine)
            
            
            addChild(player)
            //bullet create sonrası
            run(.repeatForever(.sequence([.wait(forDuration: 0.2), .run { [weak self] in self? .createBullet()
                }])))
            
        }
        
        //TODO : Fruit
        func createFruit() {
            var fruit: Fruit
            let type: FruitSettings
            let duration : CGFloat
            
            switch Int(arc4random() % 100) {
            case 0...25:
                fruit = Fruit.createFruitSmall()
                type = .small
                duration = CGFloat(Float(arc4random() % 3) + 2.0)
            case 25...50:
                fruit = Fruit.createFruitSmall2()
                type = .small
                duration = CGFloat(Float(arc4random() % 3) + 2.0)
            case 50...75:
                fruit = Fruit.createFruitMedium()
                type = .medium
                duration = CGFloat(Float(arc4random() % 3) + 3.0)
            case 75...80:
                fruit = Fruit.createFruitMedium2()
                type = .medium
                duration = CGFloat(Float(arc4random() % 3) + 3.0)
            case 80...90:
                fruit = Fruit.createFruitLarge2()
                type = .large
                duration = CGFloat(Float(arc4random() % 3) + 5.0)
            default:
                fruit = Fruit.createFruitLarge()
                type = .large
                duration = CGFloat(Float(arc4random() % 3) + 5.0)
            }
            fruit.type = type
            let fruitF = fruit.frame
            let randomX = CGFloat.random(min: fruitF.width, max: self.frame.width - fruitF.width )
            fruit.position = CGPoint(x:randomX, y: self.frame.height + fruitF.height / 2 )
            
            fruit.physicsBody = SKPhysicsBody(rectangleOf: fruit.size)
            fruit.physicsBody?.isDynamic = true
            fruit.physicsBody?.categoryBitMask = fruitCategory
            fruit.physicsBody?.contactTestBitMask = bulletCategory
            fruit.physicsBody?.collisionBitMask = 0
            
            addChild(fruit)
            let moveTo = SKAction.moveTo(y: 0.0, duration: TimeInterval(duration))
            let turnTo = SKAction.rotate(toAngle: .pi * 2, duration: TimeInterval(duration))
            let group = SKAction.group([moveTo, turnTo])
            fruit.run(.repeatForever(.sequence([ group,  .removeFromParent()])))
        }
        
        func spawnFruits() {
            var timeInterval = 2.0
            if difficulty == "easy" {
                timeInterval = 1.50
            }else{
                timeInterval = 0.75
            }
            run(.repeatForever(.sequence([
                .wait(forDuration: timeInterval),
                    .run {[weak self] in
                        self?.createFruit()
                }])))
        }
        
        
        // TODO : Bullet
        func createBullet() {
            self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
            let bullet = SKSpriteNode(imageNamed: "missile00")
            bullet.setScale(0.2)
            bullet.size = CGSize(width: 30, height: 30)
            bullet.position = player.position
            
            bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width / 2)
            bullet.physicsBody?.isDynamic = true
            bullet.physicsBody?.categoryBitMask = bulletCategory
            bullet.physicsBody?.contactTestBitMask = fruitCategory
            bullet.physicsBody?.collisionBitMask = 0
            bullet.physicsBody?.usesPreciseCollisionDetection = true
            
            addChild(bullet)
            
            let moveBy = SKAction.moveBy(x: 0.0, y: frame.height, duration: 0.5)
            bullet.run(.repeatForever(.sequence([moveBy, .removeFromParent()])))
            
        }
        
        // TODO : addLive
        
        func addLives() {
            livesArray = [SKSpriteNode]()
            
            for live in 1...3 {
                let liveNode = SKSpriteNode(imageNamed: "Spaceship_one_fruit")
                liveNode.size = CGSize(width: 75, height: 75)
                liveNode.position = CGPoint(x: self.frame.size.width - CGFloat(4-live) * liveNode.size.width, y: self.frame.height - 60)
                self.addChild(liveNode)
                livesArray.append(liveNode)
            }
            
        }
        
        
    //MARK: - SKPhysicsContactDelegate
        
        func didBegin(_ contact: SKPhysicsContact) {
            var firstBody:SKPhysicsBody
            var secondBody:SKPhysicsBody
            
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                firstBody = contact.bodyA
                secondBody = contact.bodyB
            }else{
                firstBody = contact.bodyB
                secondBody = contact.bodyA
            }
            if (firstBody.categoryBitMask & bulletCategory) != 0 && (secondBody.categoryBitMask & fruitCategory) != 0 {
            
                let fruit = contact.bodyA.categoryBitMask == fruitCategory ? contact.bodyA.node as? Fruit: contact.bodyB.node as? Fruit
                let bullet = contact.bodyB.node as? SKSpriteNode
                //let collision = contact.bodyB.categoryBitMask | contact.bodyB.contactTestBitMask
                bullet?.removeFromParent()
                if let fruit = fruit {
                    fruit.healty -= 1
                    print(fruit.healty)
                    if fruit.healty < 0 {
                        fruit.healty = 0
                            changeScore(fruit.type)
                        bulletDidCollideWithFruit(fruitNode: secondBody.node as! SKSpriteNode )
                    }
                    if fruit.healty == 0 {
                        changeScore(fruit.type)
                        bulletDidCollideWithFruit(fruitNode: secondBody.node as! SKSpriteNode )
                        
                    }else {
                        
                    }
                }
            }
            if (firstBody.categoryBitMask & playerCategory) != 2 && (secondBody.categoryBitMask & fruitCategory) != 2 {
                //Crash SpaceShip
                playerDidCollideWithFruit(playerNode: firstBody.node as! SKSpriteNode)
                if self.livesArray.count > 0 {
                    let liveNode = self.livesArray.first
                    liveNode!.removeFromParent()
                    self.livesArray.removeFirst()
                    if self.livesArray.count == 0 {
                        //GameOver screen transition
                        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                        //let gameOverScene = GameOverScene(size: self.size)
                        let gameOverScene = SKScene(fileNamed: "GameOverScene") as! GameOverScene
                        gameOverScene.scaleMode = .aspectFill
                        gameOverScene.score = self.score
                        gameOverScene.size = self.size
                        gameOverScene.difficulty = difficulty
                        gameOverScene.backgroundImage = backgroundImage
                        self.view?.presentScene(gameOverScene, transition: transition)
                    }
                    
                }
                
            }
                
        }
        
        //player fire explosion
         func playerDidCollideWithFruit (playerNode:SKSpriteNode) {
             let explosion = SKEmitterNode(fileNamed: "Explosion")!
            explosion.position = playerNode.position
             addChild(explosion)
             run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
             playerNode.removeFromParent()
             run(SKAction.wait(forDuration: 0.3)) {
                 explosion.removeFromParent()
             }
         }
        
       //bullet fire explosion
        func bulletDidCollideWithFruit (fruitNode:SKSpriteNode) {
            let explosion = SKEmitterNode(fileNamed: "bulling2")!
            explosion.position = fruitNode.position
            addChild(explosion)
            run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
            fruitNode.removeFromParent()
            run(SKAction.wait(forDuration: 0.3)) {
                explosion.removeFromParent()
            }
        }
        
        func changeScore (_ type:FruitSettings) {
            switch type {
            case .small:
                score += 100
            case .medium:
                score += 600
            case .large:
                score += 3000
            }
        }
        
        
}
    

