//
//  Moveable.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/28/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Moveable: SKSpriteNode {

    static let RESET_X_POSITION: CGFloat = -800
    static let START_X_POSITION: CGFloat = 1800

    var moveAction: SKAction!
    var moveForever: SKAction!
    var yPos: CGFloat = 0

}

// MARK: - API

extension Moveable {

    func startMoving() {
        position = CGPoint(x: Moveable.START_X_POSITION, y: yPos)

        moveAction = SKAction.moveByX(GameManager.sharedManager.GROUND_SPEED, y: 0, duration: 0.02)
        moveForever = SKAction.repeatActionForever(moveAction)
        self.runAction(moveForever)
    }

    override func update() {
        if position.x <= Moveable.RESET_X_POSITION {
            didExceedBounds()
        }
    }

    func didExceedBounds() {
        position = CGPoint(x: Moveable.START_X_POSITION, y: yPos)
    }

}
