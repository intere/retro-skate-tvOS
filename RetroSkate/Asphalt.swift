//
//  Ground.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/28/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Asphalt: SKSpriteNode {
    convenience init() {
        self.init(texture: TextureManager.sharedManager.asphaltTexture)
        setupPhysics()
    }
}


// MARK: - Helper Methods

private extension Asphalt {

    func setupPhysics() {
        let collider = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width, height: 5), center: CGPoint(x: 0, y: -10))
        collider.categoryBitMask = PhysicsBody.Rideable.rawValue

        physicsBody = collider
        physicsBody?.dynamic = false
        physicsBody?.allowsRotation = false
    }

}