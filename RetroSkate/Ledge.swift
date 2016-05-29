//
//  Ledge.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit


class Ledge: RideableObstacle {

    convenience init() {
        self.init(texture: TextureManager.sharedManager.ledgeTexture)
        xOffset = randomXOffset()
        yPos = 175
        topYOffset = 25
        zPosition = 6

        top = RideableTop(size: CGSize(width: size.width, height: 5))
    }
}

// MARK: - Overrides

extension Ledge {

    override func initPhysics() {
        let collider = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: size.height-20), center: CGPoint(x: -size.width/2, y: -5))
        collider.categoryBitMask = PhysicsBody.Obstacle.rawValue
        collider.contactTestBitMask = PhysicsBody.Player.rawValue

        physicsBody = collider

        super.initPhysics()
    }

}