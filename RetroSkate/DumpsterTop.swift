//
//  DumpsterTop.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/28/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class DumpsterTop: Obstacle {

    convenience init() {

        self.init(color: UIColor.clearColor(), size: CGSize(width: 100, height: 2))
        yPos = 220
        zPosition = 6

    }

    override func initPhysics() {

        self.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        self.physicsBody?.categoryBitMask = PhysicsBody.Rideable.rawValue

        super.initPhysics()

    }

}
