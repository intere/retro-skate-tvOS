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
        self.init(texture: TextureManager.sharedManager.skaterPushTextures.first)
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

// MARK: - API

extension Player {

    func jump() {
        guard !isJumping else {
            print("👎 We can't jump, we're already jumping.  Idiot!")
            return
        }
        physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
        isJumping = true
        runAction(SKAction.playSoundFileNamed("sfxOllie.wav", waitForCompletion: false))
        runAction(SKAction.animateWithTextures(TextureManager.sharedManager.skaterOllieTextures, timePerFrame: 0.04))
    }

    func hardflip() {
        guard isJumping else {
            print("Can't do a hardflip if we're not jumping.  Idiot!")
            return
        }
        runAction(SKAction.animateWithTextures(TextureManager.sharedManager.skaterHardflipTextures, timePerFrame: 0.04))
    }

    func playPushAnimation() {
        removeAllActions()
        runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureManager.sharedManager.skaterPushTextures, timePerFrame: 0.1)))
    }

    func playCrashAnimation() {
        removeAllActions()
        runAction(SKAction.animateWithTextures(TextureManager.sharedManager.skaterCrashTextures, timePerFrame: 0.04))
    }

}

// MARK: - Helper Methods

extension Player {

    func setupCharacter() {
        position = CHARACTER_POSITION
        zPosition = 10
        configurePhysicsBody()
        playPushAnimation()
    }

    /// Configure the Physics Body for a Skater
    func configurePhysicsBody() {
        let bottomCollider = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width / 2, height: size.height-30), center: CGPoint(x: 0, y: -5))
        physicsBody = bottomCollider
        physicsBody?.restitution = 0
        physicsBody?.linearDamping = 0.1
        physicsBody?.allowsRotation = false
        physicsBody?.mass = 0.1
        physicsBody?.dynamic = true
        physicsBody?.categoryBitMask = PhysicsBody.Player.rawValue
        physicsBody?.contactTestBitMask = PhysicsBody.Obstacle.rawValue
    }
}