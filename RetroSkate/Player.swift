//
//  Player.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit


class Player: SKSpriteNode {
    let CHARACTER_POSITION = CGPointMake(158, 180)
    var isJumping = false

    convenience init() {
        self.init(texture: TextureManager.sharedManager.skaterAnimationTextures.first)
        setupCharacter()
    }

    override func update() {
        guard let physicsBody = physicsBody where isJumping else {
            return
        }
        if Int(physicsBody.velocity.dy) == 0 {
            isJumping = false
        }
    }
}

// MARK: - Public Interface

extension Player {

    func jump() {
        guard !isJumping else {
            print("👎 We can't jump, we're already jumping.  Idiot!")
            position = CHARACTER_POSITION
            return
        }
        physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
        isJumping = true
    }

}

// MARK: - Helper Methods

extension Player {

    func setupCharacter() {
        position = CHARACTER_POSITION
        zPosition = 10
        runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureManager.sharedManager.skaterAnimationTextures, timePerFrame: 0.1)))

        configurePhysicsBody()
    }

    /// Configure the Physics Body for a Skater
    func configurePhysicsBody() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: size.height * 0.8), center: CGPoint(x: 25, y: 0 ))
        let bottomCollider = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width / 2, height: 5), center: CGPoint(x: 0, y: -size.height / 2 + 5))

        physicsBody = SKPhysicsBody(bodies: [frontCollider, bottomCollider])
        physicsBody?.restitution = 0
        physicsBody?.linearDamping = 0.1
        physicsBody?.allowsRotation = false
        physicsBody?.mass = 0.1
        physicsBody?.dynamic = true
        physicsBody?.categoryBitMask = PhysicsBody.Player.rawValue
        physicsBody?.contactTestBitMask = PhysicsBody.Obstacle.rawValue
    }
}