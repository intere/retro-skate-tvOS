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
    }

    override func initPhysics() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: size.height), center: CGPoint(x: -size.width/2, y: 0))
        let topCollider = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width*0.8, height: 5), center: CGPoint(x: 0, y: size.height/2 - 7))

        physicsBody = SKPhysicsBody(bodies: [frontCollider, topCollider])
        super.initPhysics()
    }
}
