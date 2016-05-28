//
//  GameScene.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright (c) 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let ASP_PIECES = 15
    let SIDEWALK_PIECES = 24
    let X_RESET: CGFloat = -912

    var player: Player!

    override func didMoveToView(view: SKView) {
        setupBackground()
        setupGround()

        setupActions()

        player = Player()
        addChild(player)

        setupObstacles()

        setupPhysics()
    }
   
    override func update(currentTime: CFTimeInterval) {

        ScrollingSceneryManager.sharedManager.update()

        for child in children {
            child.update()
        }
    }

}

// MARK: - Setup Methods

extension GameScene {

    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        physicsWorld.contactDelegate = self
    }

    func setupBackground() {

        var farBG = [FarBackground]()
        var midBG = [MidBackground]()
        var frontBG = [FrontBackground]()

        for _ in 0..<3 {
            let frontBackground = FrontBackground()
            frontBG.append(frontBackground)
            addChild(frontBackground)

            let midBackground = MidBackground()
            midBG.append(midBackground)
            addChild(midBackground)

            let farBackground = FarBackground()
            farBG.append(farBackground)
            addChild(farBackground)
        }

        ScrollingSceneryManager.sharedManager.addScrollingScenery(frontBG, startPosition: CGPoint(x: 0, y: 400), resetXPosition: X_RESET, moveSpeed: -2)
        ScrollingSceneryManager.sharedManager.addScrollingScenery(midBG, startPosition: CGPoint(x: 0, y: 450), resetXPosition: X_RESET, moveSpeed: -1)
        ScrollingSceneryManager.sharedManager.addScrollingScenery(farBG, startPosition: CGPoint(x: 0, y: 500), resetXPosition: X_RESET, moveSpeed: -0.5)
    }

    func setupGround() {
        var asphaltPieces = [SKSpriteNode]()

        for _ in 0..<ASP_PIECES {
            let asphalt = Asphalt()
            asphaltPieces.append(asphalt)
            addChild(asphalt)
        }
        ScrollingSceneryManager.sharedManager.addScrollingScenery(asphaltPieces, startPosition: CGPoint(x: 0, y: 144), resetXPosition: GameManager.sharedManager.GROUND_X_RESET, moveSpeed: GameManager.sharedManager.GROUND_SPEED)

        var sidewalkPieces = [SKSpriteNode]()

        for _ in 0..<SIDEWALK_PIECES {
            let sidewalk = Sidewalk()
            sidewalkPieces.append(sidewalk)
            addChild(sidewalk)
        }
        ScrollingSceneryManager.sharedManager.addScrollingScenery(sidewalkPieces, startPosition: CGPoint(x: 0, y: 190), resetXPosition: GameManager.sharedManager.GROUND_X_RESET, moveSpeed: GameManager.sharedManager.GROUND_SPEED)
    }

    func setupObstacles() {
        let dumpster = Dumpster()
        addChild(dumpster)
        dumpster.startMoving()
    }

    func setupActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        view?.addGestureRecognizer(tap)
    }
}

// MARK: - SKPhysicsContactDelegate Methods

extension GameScene : SKPhysicsContactDelegate {

    func didBeginContact(contact: SKPhysicsContact) {

        if contact.bodyA.categoryBitMask == PhysicsBody.Obstacle.rawValue || contact.bodyB.categoryBitMask == PhysicsBody.Obstacle.rawValue {
            print("💀 Hit an obstacle.  Skate or Die!  Oh, you died.  😬")
        }

    }

}

// MARK: - Actions

extension GameScene {

    func tapped(gesture: UITapGestureRecognizer) {
        player.jump()
    }

}
