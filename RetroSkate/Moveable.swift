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
    var xOffset: CGFloat = 0
    var removeOnExceed: Bool = false

}

// MARK: - API

extension Moveable {

    func startMoving() {
        position = CGPoint(x: Moveable.START_X_POSITION + xOffset, y: yPos)

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
        guard !removeOnExceed else {
            removeMe()
            return
        }
        position = CGPoint(x: Moveable.START_X_POSITION + xOffset, y: yPos)
    }

}

// MARK: - Helpers

extension Moveable {

    func randomInt(min: Int, max: Int) -> Int {
        let random = Int(arc4random_uniform(UInt32(max - min))) + min
        return random
    }

    func randomFloat(min: CGFloat, max: CGFloat) -> CGFloat {
        let intMin = Int(min * 1000)
        let intMax = Int(max * 1000)

        return CGFloat(randomInt(intMin, max: intMax)) / 1000
    }

    func randomXOffset() -> CGFloat {
        return randomFloat(-500, max: 500)
    }

}

// MARK: - Private Helpers

private extension Moveable {

    func removeMe() {
        if let rideable = self as? RideableObstacle {
            rideable.top.removeFromParent()
        }
        removeFromParent()
    }

}
