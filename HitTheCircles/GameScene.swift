//
//  GameScene.swift
//  HitTheCircles
//
//  Created by Philip Henson on 1/23/16.
//  Copyright (c) 2016 Phil Henson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var scoreLabel: SKLabelNode!

    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }

    var lives: Int = 3

    var heartPositions = [CGPoint]()

    // MARK: Setup Scene
    override func didMoveToView(view: SKView) {

        backgroundColor = SKColor.whiteColor()

        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addCircle),
                SKAction.waitForDuration(1.0)
                ])
            ))

        scoreLabel = SKLabelNode(fontNamed: "Futura")
        scoreLabel.text = "0"
        scoreLabel.horizontalAlignmentMode = .Left
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.position = CGPoint(x: 30.0, y: size.height - 30.0)
        addChild(scoreLabel)

        heartPositions = [CGPoint(x: size.width - 120, y: size.height-30),
            CGPoint(x: size.width-80, y: size.height - 30),
            CGPoint(x: size.width-40, y: size.height - 30)]

        for point in heartPositions {
            addHeart(point)
        }

    }

    // MARK: Handle touches
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        for touch in touches {
            let location = (touch as UITouch).locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
                if touchedNode.name == "circle" {
                    touchedNode.removeFromParent()
                    score++
                }
        }
    }

    // MARK: Randomization helper methods
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

    // MARK: Create Sprites
    func addCircle() {

        let circle = SKSpriteNode(imageNamed: "circle")

        circle.name = "circle"
        circle.userInteractionEnabled = false

        let yPos = random(min: circle.size.height/2, max: size.height - circle.size.height/2)
        let xPos = random(min: circle.size.width/2, max: size.width - circle.size.width/2)
        circle.position = CGPoint(x: xPos, y: yPos)
        addChild(circle)

        let actionScale = SKAction.scaleTo(0.0, duration: 2.0)
        let actionScaleDone = SKAction.removeFromParent()

        let loseAction = SKAction.runBlock() {
            self.removeHearts()
            self.lives--
            if (self.lives <= 0) {
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let gameOverScene = GameOverScene(size: self.size, score: self.score)
                self.view?.presentScene(gameOverScene, transition: reveal)
            }
        }

        circle.runAction(SKAction.sequence([actionScale, loseAction, actionScaleDone]))

    }

    func addHeart(atPoint: CGPoint) {
        let heart = SKSpriteNode(imageNamed: "heart")
        heart.name = "heart"
        heart.position = atPoint
        addChild(heart)
    }

    func removeHearts() {
        for point in heartPositions {
            let touchedNode = self.nodeAtPoint(point)
            if touchedNode.name == "heart" {
                touchedNode.removeFromParent()
                return
            }
        }
    }

}
