//
//  Obstacle.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Obstacle: SKSpriteNode {

    static let RESET_X_POSITION: CGFloat = -800
    static let START_X_POSITION: CGFloat = 1800
    static let START_Y_POSITION: CGFloat = 180

    var moveAction: SKAction!
    var moveForever: SKAction!

}

// MARK: - Public Interface

extension Obstacle {

    func initPhysics() {
        physicsBody?.dynamic = false
        physicsBody?.categoryBitMask = PhysicsBody.Obstacle.rawValue
        physicsBody?.contactTestBitMask = PhysicsBody.Player.rawValue
    }

    func startMoving() {
        position = CGPoint(x: Obstacle.START_X_POSITION, y: Obstacle.START_Y_POSITION)

        moveAction = SKAction.moveByX(GameManager.sharedManager.GROUND_SPEED, y: 0, duration: 0.02)
        moveForever = SKAction.repeatActionForever(moveAction)
        self.zPosition = 7
        self.runAction(moveForever)
        initPhysics()
    }


    override func update() {
        if position.x <= Obstacle.RESET_X_POSITION {
            position = CGPoint(x: Obstacle.START_X_POSITION, y: Obstacle.START_Y_POSITION)
        }
    }
}
