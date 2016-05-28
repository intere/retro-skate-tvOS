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
    let BACKGROUND_X_RESET: CGFloat = -912

    var player: Player!
    var dumpster: Dumpster!
    var dumpsterTop: DumpsterTop!

    var buildings = [SKSpriteNode]()
    var gameOver = false

    override func didMoveToView(view: SKView) {
        setupBackground()
        setupGround()

        setupActions()

        player = Player()
        addChild(player)

        setupObstacles()

        setupPhysics()
        playLevelMusic()
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

        ScrollingSceneryManager.sharedManager.addScrollingScenery(frontBG, startPosition: CGPoint(x: 0, y: 400), resetXPosition: BACKGROUND_X_RESET, moveSpeed: -2)
        ScrollingSceneryManager.sharedManager.addScrollingScenery(midBG, startPosition: CGPoint(x: 0, y: 450), resetXPosition: BACKGROUND_X_RESET, moveSpeed: -1)
        ScrollingSceneryManager.sharedManager.addScrollingScenery(farBG, startPosition: CGPoint(x: 0, y: 500), resetXPosition: BACKGROUND_X_RESET, moveSpeed: -0.5)
    }

    func setupGround() {
        var asphaltPieces = [SKSpriteNode]()

        for _ in 0..<ASP_PIECES {
            let asphalt = Asphalt()
            asphaltPieces.append(asphalt)
            addChild(asphalt)
        }
        ScrollingSceneryManager.sharedManager.addScrollingScenery(asphaltPieces, startPosition: CGPoint(x: 0, y: 145), resetXPosition: GameManager.sharedManager.GROUND_X_RESET, moveSpeed: GameManager.sharedManager.GROUND_SPEED)

        var sidewalkPieces = [SKSpriteNode]()

        for _ in 0..<SIDEWALK_PIECES {
            let sidewalk = Sidewalk()
            sidewalkPieces.append(sidewalk)
            addChild(sidewalk)
        }
        ScrollingSceneryManager.sharedManager.addScrollingScenery(sidewalkPieces, startPosition: CGPoint(x: 0, y: 190), resetXPosition: GameManager.sharedManager.GROUND_X_RESET, moveSpeed: GameManager.sharedManager.GROUND_SPEED)
    }

    func setupObstacles() {
        dumpster = Dumpster()
        addChild(dumpster)
        dumpster.startMoving()

        dumpsterTop = DumpsterTop()
        addChild(dumpsterTop)
        dumpsterTop.position = CGPoint(x: dumpster.position.x, y: dumpster.position.y + 50)
        dumpsterTop.startMoving()

        for i  in 0..<3 {
            let wait = SKAction.waitForDuration(NSTimeInterval(2 * i))
            runAction(wait) {
                guard !self.gameOver else {
                    return
                }
                let building = Building()
                self.buildings.append(building)
                self.addChild(building)
                building.startMoving()
            }
        }
    }

    func setupActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        view?.addGestureRecognizer(tap)
    }


    func playLevelMusic() {
        AudioManager.sharedManager.playLevelMusic()
    }

    func stopPlayLevelMusic() {
        AudioManager.sharedManager.stopLevelMusic()
    }

    func playGameOverSound() {
        runAction(SKAction.playSoundFileNamed("sfxGameOver.wav", waitForCompletion: false))
    }
}

// MARK: - SKPhysicsContactDelegate Methods

extension GameScene : SKPhysicsContactDelegate {

    func didBeginContact(contact: SKPhysicsContact) {
        guard !gameOver else {
            return
        }
        guard contact.bodyA.categoryBitMask != PhysicsBody.Rideable.rawValue && contact.bodyB.categoryBitMask != PhysicsBody.Rideable.rawValue else {
            return
        }

        print("💀 Collision")

        if contact.bodyA.categoryBitMask == PhysicsBody.Obstacle.rawValue {
            handleCollision()
        } else if contact.bodyB.categoryBitMask == PhysicsBody.Obstacle.rawValue {
            handleCollision()
        }
    }

}

// MARK: - Actions

extension GameScene {

    func tapped(gesture: UITapGestureRecognizer) {
        guard !gameOver else {
            return
        }
        player.jump()
    }

}


// MARK: - Helpers

private extension GameScene {

    func handleCollision() {
        dumpster.physicsBody?.dynamic = false
        dumpsterTop.physicsBody?.dynamic = false
        dumpster.physicsBody = nil
        dumpsterTop.physicsBody = nil
        gameOver = true

        for node in children {
            node.removeAllActions()
        }

        player.playCrashAnimation()
        stopPlayLevelMusic()
        playGameOverSound()

        runAction(SKAction.sequence([SKAction.waitForDuration(5), SKAction.runBlock {
            guard let scene = GameScene(fileNamed: "GameScene") else {
                return
            }
            scene.scaleMode = .AspectFill
            self.view!.presentScene(scene, transition: SKTransition.crossFadeWithDuration(1))
        }]))
    }

}