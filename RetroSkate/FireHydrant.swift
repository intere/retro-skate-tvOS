//
//  FireHydrant.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class FireHydrant: Obstacle {

    convenience init() {
        self.init(texture: TextureManager.sharedManager.fireHydrantTexture)
        xOffset = randomXOffset()
        yPos = 170
        zPosition = 6
    }

}

// MARK: - Overrides

extension FireHydrant {

    override func initPhysics() {
        let collider = SKPhysicsBody(rectangleOfSize: size)
        collider.categoryBitMask = PhysicsBody.Obstacle.rawValue
        collider.contactTestBitMask = PhysicsBody.Player.rawValue

        self.physicsBody = collider
        super.initPhysics()
    }

    override func didExceedBounds() {
        xOffset = randomXOffset()
        super.didExceedBounds()
    }

}