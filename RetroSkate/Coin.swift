//
//  Coin.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/28/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Coin: Obstacle {

    static let CLEANUP_X: CGFloat = -500

    convenience init() {
        self.init(texture: TextureManager.sharedManager.coinTexture)
        self.xScale = 0.5
        self.yScale = 0.5
        zPosition = 9
    }

    override func initPhysics() {

        let collider = SKPhysicsBody(circleOfRadius: size.width-25)
        collider.categoryBitMask = PhysicsBody.Coin.rawValue
        collider.contactTestBitMask = PhysicsBody.Player.rawValue
        physicsBody = collider

        super.initPhysics()
    }

}

// MARK: - API

extension Coin {

    func randomizePosition() {

        yPos = CGFloat(arc4random_uniform(200) + 150)
        position = CGPoint(x: 1000, y: yPos)

    }

    override func update() {
        if position.x < Coin.CLEANUP_X {
            removeFromParent()
        }
    }
}
