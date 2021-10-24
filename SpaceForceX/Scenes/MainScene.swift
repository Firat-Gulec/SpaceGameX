//
//  MyScene.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 12.05.2020.
//  Copyright © 2020 Firat Gulec. All rights reserved.
//

import UIKit
import SpriteKit
import StoreKit



class MainScene: SKScene, SKProductsRequestDelegate, SKPaymentTransactionObserver {

    
    
    // MARK: -In - Purchasing Setup Start
    
    private var models = [SKProduct]()
    //Protucts
    
    enum Product: String, CaseIterable {
        case unlockEverything = "com.firatgulec.SpaceForceX.everything"
        case removeAds = "com.firatgulec.SpaceForceX.removeads"
        
    }
    
    private func fetchProduct() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.sync {
            models = response.products
            print("Count: \(response.products.count)")
        }
        
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //no code
        transactions.forEach({
            switch $0.transactionState {
            case .purchasing:
                print("purchasing")
            case .purchased:
                if backgroundImage == "bg_02.png" {
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    let candyscene = CandyScene(size: self.size)
                    candyscene.difficulty = difficulty
                    self.view?.presentScene(candyscene, transition: transition)
                }else if backgroundImage == "bg_03.png" {
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    let fruitscene = FruitScene(size: self.size)
                    fruitscene.difficulty = difficulty
                    self.view?.presentScene(fruitscene, transition: transition)
                }
                print("purchased")
            case .failed:
                print("did not purchase")
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        })
    }
    
    // MARK: -Game Start
    
        var gamelogoLabelNode:SKLabelNode!
        var newGameButtonNode:SKSpriteNode!
        var difficultyButtonNode:SKSpriteNode!
        var difficultyLabelNode:SKLabelNode!
        var gameModeButtonNode:SKSpriteNode!
        var gameImageNode:SKSpriteNode!
    
        var difficulty = String()
        var gamemode = String()
        var backgroundImage = String()
           
           override func didMove(to view: SKView) {
            
            fetchProduct()
            //let payment = SKPayment(product: models[1])
            //SKPaymentQueue.default().add(payment)
            SKPaymentQueue.default().add(self)
            
            
            
            if backgroundImage == "" {
                backgroundImage = "bg_01.png"
            }
               createBG()
            gamelogoLabelNode = (self.childNode(withName: "gamelogoLabel") as! SKLabelNode)
            gamelogoLabelNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 300)
            newGameButtonNode = (self.childNode(withName: "newGameButton") as! SKSpriteNode)
            newGameButtonNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 400)
            difficultyButtonNode = (self.childNode(withName: "difficultyButton") as! SKSpriteNode)
            // difficultyButtonNode.texture = SKTexture(imageNamed: ""slots-difficulty"")
            difficultyLabelNode = (self.childNode(withName: "difficultyLabel")as! SKLabelNode)
            difficultyLabelNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 900)
            difficultyButtonNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 800)
            gameModeButtonNode = (self.childNode(withName: "gameModeButton")as! SKSpriteNode)
            gameModeButtonNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 500)
            gameImageNode = (self.childNode(withName: "gameImage")as! SKSpriteNode)
            gameImageNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 650)
            gamemode = "slots-Meteormode.png"
            gameImageNode.texture = SKTexture(imageNamed: gamemode)
            let userDefaults = UserDefaults.standard
            if userDefaults.bool(forKey:"hard") {
                difficultyLabelNode.text = "Hard"
            }else {
                difficultyLabelNode.text = "Easy"
            }
            
           }
    
    
        override func update(_ currentTime: TimeInterval) {
            moveBG()
        }
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            
            if let location = touch?.location(in: self) {
                let nodesArray = self.nodes(at: location)
                
                if nodesArray.first?.name == "newGameButton" {
                    if backgroundImage == "bg_01.png" {
                        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                        let meteorscene = MeteorScene(size: self.size)
                        meteorscene.difficulty = difficulty
                        self.view?.presentScene(meteorscene, transition: transition)
                    }
                    if backgroundImage == "bg_02.png" {
                        let payment = SKPayment(product: models[0])
                        SKPaymentQueue.default().add(payment)
                    }
                    if backgroundImage == "bg_03.png" {
                        let payment = SKPayment(product: models[0])
                        SKPaymentQueue.default().add(payment)
                    }
                    
                    
                    
                }else if nodesArray.first?.name == "difficultyButton" {
                    changeDifficulty()
                }else if nodesArray.first?.name == "gameModeButton" {
                    changeGameMode()
                }
            }
        }
    
    func changeGameMode() {
        let userDefaults = UserDefaults.standard
        if gamemode == "slots-Meteormode.png" {
            userDefaults.set(true, forKey: "meteor")
            backgroundImage = "bg_02.png"
            gamemode = "slots-Candymode.png"
            gameImageNode.texture = SKTexture(imageNamed: gamemode)
        }else if gamemode == "slots-Candymode.png" {
            userDefaults.set(true, forKey: "candy")
            backgroundImage = "bg_03.png"
            gamemode = "slots-Fruitmode.png"
            gameImageNode.texture = SKTexture(imageNamed: gamemode)
        }else if gamemode == "slots-Fruitmode.png" {
            userDefaults.set(true, forKey: "fruit")
            backgroundImage = "bg_01.png"
            gamemode = "slots-Meteormode.png"
            gameImageNode.texture = SKTexture(imageNamed: gamemode)
        }
        userDefaults.synchronize()
        
    }
    
    
    func changeDifficulty() {
        let userDefaults = UserDefaults.standard
        if difficultyLabelNode.text == "Easy" {
            userDefaults.set(true, forKey: "hard")
            difficultyLabelNode.text = "Hard"
            difficulty = "hard"
        }else {
            difficultyLabelNode.text = "Easy"
            userDefaults.set(true, forKey: "easy")
            difficulty = "easy"
        }
        
        userDefaults.synchronize()
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
    
    
    
    
    }
