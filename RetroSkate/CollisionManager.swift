//
//  CollisionManager.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class CollisionManager {
    static let sharedManager = CollisionManager()

    var scene: GameScene?

}

// MARK: - API

extension CollisionManager {

    func handleCollision(contact: SKPhysicsContact) {
        guard GameManager.sharedManager.isPlayerAlive() else {
            return
        }
        guard contact.bodyA.categoryBitMask != PhysicsBody.Rideable.rawValue && contact.bodyB.categoryBitMask != PhysicsBody.Rideable.rawValue else {
            return
        }

        if let coin = contact.bodyA.node as? Coin ?? contact.bodyB.node as? Coin {
            handleCoinCollection(coin)
        } else if let dumpster = contact.bodyA.node as? Dumpster ?? contact.bodyB.node as? Dumpster {
            handleDumpsterCollision(dumpster)
        } else if let hydrant = contact.bodyA.node as? FireHydrant ?? contact.bodyB.node as? FireHydrant {
            handleFireHydrantCollision(hydrant)
        }
    }

}

// MARK: - Helper Methods

extension CollisionManager {

    func handleCoinCollection(coin: SKNode) {
        guard let scene = scene else {
            return
        }

        GameManager.sharedManager.score += 1
        coin.removeAllActions()
        coin.removeFromParent()
        scene.runAction(SKAction.playSoundFileNamed("sfxButtonPress.wav", waitForCompletion: false))
    }

    func handleDumpsterCollision(dumpster: Dumpster) {
        dumpster.physicsBody?.dynamic = false
        dumpster.top.physicsBody?.dynamic = false
        dumpster.physicsBody = nil
        dumpster.top.physicsBody = nil

        crashAndDie()
    }

    func handleFireHydrantCollision(hydrant: FireHydrant) {
        hydrant.physicsBody?.dynamic = false
        hydrant.physicsBody = nil

        crashAndDie()
    }

    func crashAndDie() {
        guard let scene = scene else {
            return
        }

        GameManager.sharedManager.playerDead = true
        GameManager.sharedManager.lives -= 1
        for node in scene.children {
            node.removeAllActions()
        }

        scene.player.playCrashAnimation()
        scene.stopPlayLevelMusic()

        guard GameManager.sharedManager.lives > 0 else {
            // TODO: Handle Game Over
            scene.runAction(SKAction.waitForDuration(1)) {
                scene.playGameOverSound()
            }
            print("GAME OVER!!!")
            return
        }

        scene.runAction(SKAction.sequence([SKAction.waitForDuration(5), SKAction.runBlock {
            guard let newScene = GameScene(fileNamed: "GameScene") else {
                return
            }
            newScene.scaleMode = .AspectFill
            scene.view!.presentScene(newScene, transition: SKTransition.crossFadeWithDuration(1))
        }]))

    }

}