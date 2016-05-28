//
//  Dumpster.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Dumpster: Obstacle {

    convenience init() {
        self.init(texture: TextureManager.sharedManager.dumpsterTexture)
        yPos = 180
        zPosition = 6
    }

    override func initPhysics() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: size.height-20), center: CGPoint(x: -size.width/2, y: 0))
        frontCollider.categoryBitMask = PhysicsBody.Obstacle.rawValue
        frontCollider.contactTestBitMask = PhysicsBody.Player.rawValue

        physicsBody = frontCollider


        super.initPhysics()
    }
}
