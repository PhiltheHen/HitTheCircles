//
//  GameScene.swift
//  HitTheCircles
//
//  Created by Philip Henson on 1/23/16.
//  Copyright (c) 2016 Phil Henson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    let score = 0

    // MARK: Setup Scene
    override func didMoveToView(view: SKView) {

        backgroundColor = SKColor.whiteColor()

        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addCircle),
                SKAction.waitForDuration(1.0)
                ])
            ))

        let scoreLabel = SKLabelNode(fontNamed: "Futura")
        scoreLabel.text = String(score)

    }

    // MARK: Handle touches
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = (touch as UITouch).locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
                if touchedNode.name == "circle" {
                    touchedNode.removeFromParent()
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

        circle.runAction(SKAction.sequence([actionScale, actionScaleDone]))

    }
}
