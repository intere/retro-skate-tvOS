//
//  Dumpster.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Dumpster: RideableObstacle {

    convenience init() {
        self.init(texture: TextureManager.sharedManager.dumpsterTexture)
        xOffset = randomXOffset()
        yPos = 180
        topYOffset = 35
        zPosition = 6
        top = RideableTop(size: CGSize(width: size.width, height: 5))
    }

}

// MARK: - Overrides

extension Dumpster {

    override func initPhysics() {
        let collider = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: size.height-20), center: CGPoint(x: -size.width/2, y: -5))
        collider.categoryBitMask = PhysicsBody.Obstacle.rawValue
        collider.contactTestBitMask = PhysicsBody.Player.rawValue

        physicsBody = collider

        super.initPhysics()
    }

}