//
//  Rideable.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Rideable: Obstacle {

    override func initPhysics() {

        self.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        self.physicsBody?.categoryBitMask = PhysicsBody.Rideable.rawValue

        super.initPhysics()
        
    }
}
