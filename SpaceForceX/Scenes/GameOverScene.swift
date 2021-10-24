//
//  GameOverScene.swift
//  SpaceForceX
//
//  Created by Fırat GÜLEÇ on 18.05.2020.
//  Copyright © 2020 Firat Gulec. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData



class GameOverScene: SKScene {
    
    

    var defaults = UserDefaults.standard
    var score:Int = 0
    var highScore = Int()
    
    var gamelogoLabelNode:SKLabelNode!
    var gameoverLabelNode:SKLabelNode!
    var goscoreLabelNode:SKLabelNode!
    var highscoreLabelNode:SKLabelNode!
    var newGameButtonNode:SKSpriteNode!
    var shareButtonNode:SKSpriteNode!
    //değiiştit..
    //tevelkembek
    var backgroundImage = String()
    var difficulty = String()
    //test
    override func didMove(to view: SKView) {
        //

        createBG()
        gamelogoLabelNode = (self.childNode(withName: "gamelogoLabel") as! SKLabelNode)
        gamelogoLabelNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 400)
        gameoverLabelNode = (self.childNode(withName: "gameoverLabel") as! SKLabelNode)
        gameoverLabelNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 600)
        goscoreLabelNode = (self.childNode(withName: "scoreLabel") as! SKLabelNode)
        goscoreLabelNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 700)
        highscoreLabelNode = (self.childNode(withName: "hscoreLabel") as! SKLabelNode)
        highscoreLabelNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 800)
        goscoreLabelNode.text = "SCORE :\(score)"
        highScore = defaults.integer(forKey: "high")
        highscoreLabelNode.text = "HIGH SCORE: \(highScore)"
        newGameButtonNode = (self.childNode(withName: "newGameButton") as! SKSpriteNode)
        newGameButtonNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 900)
        newGameButtonNode.texture = SKTexture(imageNamed: "slots-play")
        shareButtonNode = (self.childNode(withName: "shareButton") as! SKSpriteNode)
        shareButtonNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 1200)
        shareButtonNode.texture = SKTexture(imageNamed: "share")
        if backgroundImage == "bg_02.png" {
            goscoreLabelNode.fontColor = .black
            highscoreLabelNode.fontColor = .black
            gameoverLabelNode.fontColor = .black
            gamelogoLabelNode.fontColor = .black
        }
        if  score > highScore {          // Your test was wrong
                        highScore = score          // Taht is the new highScore
                        defaults.set(highScore, forKey: "high")
                        highscoreLabelNode.text = "HIGH SCORE: \(highScore)"
                    }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
           if node[0].name == "newGameButton" {
            if backgroundImage == "bg_01.png" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let meteorscene = MeteorScene(size: self.size)
                meteorscene.difficulty = difficulty
                self.view?.presentScene(meteorscene, transition: transition)
            }else if backgroundImage == "bg_02.png" {
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
           }else if node[0].name == "shareButton" {
            let postText: String = "Check out my score! Can you beat it?"
            let postImage: UIImage = getScreenshot(scene: self.scene!)
            let activityItems = [postText, postImage] as [Any]
            let activityController = UIActivityViewController(
                activityItems: activityItems,
                applicationActivities: nil)
           
            activityController.popoverPresentationController?.sourceView = self.view
            activityController.popoverPresentationController?.sourceRect = CGRect(x: scene!.view!.bounds.midX, y: scene!.view!.bounds.midY,width: 0,height: 0)
            activityController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            UIApplication.shared.windows.first?.rootViewController?.present(activityController, animated: true, completion: nil)
            
           /* let controller: UIViewController = scene!.view!.window!.rootViewController!
            controller.present(
                activityController,
                animated: true,
                completion: nil)*/
           }

        }
        
    }
    
    //SHARE : Screenshot
    
    func getScreenshot(scene: SKScene) -> UIImage {
        let snapshotView = scene.view!.snapshotView(afterScreenUpdates: true)
        let bounds = UIScreen.main.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        snapshotView!.drawHierarchy(in: bounds, afterScreenUpdates: true)
        let screenshotImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return screenshotImage;
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
}
