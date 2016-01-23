//
//  GameOverScene.swift
//  HitTheCircles
//
//  Created by Philip Henson on 1/23/16.
//  Copyright © 2016 Phil Henson. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {

    init(size: CGSize, score: Int) {
        super.init(size: size)

        backgroundColor = SKColor.whiteColor()

        let gameOverLabel = SKLabelNode(fontNamed: "Futura")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = SKColor.blackColor()
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/2 + 24)
        addChild(gameOverLabel)

        let scoreLabel = SKLabelNode(fontNamed: "Futura")
        scoreLabel.text = "Final Score: \(score)"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height/2 - 24)
        addChild(scoreLabel)



        runAction(SKAction.sequence([SKAction.waitForDuration(3.0), SKAction.runBlock() {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameScene(size: size)
            self.view?.presentScene(scene, transition: reveal)
            }
            ]))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}