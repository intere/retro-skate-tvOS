//
//  Rail.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Rail: RideableObstacle {

    convenience init() {
        self.init(texture: TextureManager.sharedManager.railTexture)
        xOffset = randomXOffset()
        topYOffset = 20
        yPos = 150
        zPosition = 6
        top = RideableTop(size: CGSize(width: size.width, height: 5))
    }
}

// MARK: - Overrides

extension Rail {

    override func initPhysics() {
        let collider = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: size.height), center: CGPoint(x: -size.width/2, y: 0))
        collider.categoryBitMask = PhysicsBody.Obstacle.rawValue
        collider.contactTestBitMask = PhysicsBody.Player.rawValue

        physicsBody = collider

        super.initPhysics()
    }

}
