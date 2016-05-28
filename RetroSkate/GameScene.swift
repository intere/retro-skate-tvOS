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

    var asphaltPieces = [SKSpriteNode]()
    var sidewalkPieces = [SKSpriteNode]()
    var farBG = [SKSpriteNode]()
    var midBG = [SKSpriteNode]()
    var frontBG = [SKSpriteNode]()

    var moveGroundAction: SKAction!
    var moveGroundActionForever: SKAction!
    var backgroundActions = [SKAction]()

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
        groundMovement()

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

        var action: SKAction!

        for i in 0..<3 {

            let bg = SKSpriteNode(texture: TextureManager.sharedManager.bg1Texture)
            bg.position = CGPoint(x: i * Int(bg.size.width), y: 400)
            bg.zPosition = 3
            addChild(bg)
            action = SKAction.repeatActionForever(SKAction.moveByX(-2.0, y: 0, duration: 0.02))
            bg.runAction(action)
            frontBG.append(bg)
            backgroundActions.append(action)

            let bg2 = SKSpriteNode(texture: TextureManager.sharedManager.bg2Texture)
            bg2.position = CGPoint(x: i * Int(bg2.size.width), y: 450)
            bg2.zPosition = 2
            addChild(bg2)
            action = SKAction.repeatActionForever(SKAction.moveByX(-1.0, y: 0, duration: 0.02))
            bg2.runAction(action)
            midBG.append(bg2)
            backgroundActions.append(action)

            let bg3 = SKSpriteNode(texture: TextureManager.sharedManager.bg3Texture)
            bg3.position = CGPoint(x: i * Int(bg3.size.width), y: 500)
            bg3.zPosition = 1
            addChild(bg3)
            action = SKAction.repeatActionForever(SKAction.moveByX(-0.5, y: 0, duration: 0.02))
            bg3.runAction(action)
            farBG.append(bg3)
            backgroundActions.append(action)
        }

    }

    func setupGround() {
        moveGroundAction = SKAction.moveByX(GameManager.sharedManager.GROUND_SPEED, y: 0, duration: 0.02)
        moveGroundActionForever = SKAction.repeatActionForever(moveGroundAction)

        for i in 0..<ASP_PIECES {
            let ground = SKSpriteNode(texture: TextureManager.sharedManager.asphaltTexture)
            asphaltPieces.append(ground)

            ground.position = CGPoint(x: Int(ground.size.width) * i, y: 144)
            addChild(ground)
            ground.runAction(moveGroundActionForever)

            let collider = SKPhysicsBody(rectangleOfSize: CGSize(width: ground.size.width, height: 5), center: CGPoint(x: 0, y: -20))
            ground.physicsBody = collider

            ground.physicsBody?.dynamic = false
            ground.physicsBody?.allowsRotation = false
        }

        for i in 0..<SIDEWALK_PIECES {
            let sidewalk = SKSpriteNode(texture: TextureManager.sharedManager.sidewalkTexture)
            sidewalkPieces.append(sidewalk)

            sidewalk.position = CGPoint(x: Int(sidewalk.size.width) * i, y: 190)
            sidewalk.zPosition = 5
            sidewalk.runAction(moveGroundActionForever)

            addChild(sidewalk)
        }
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
            print("💀 Hit an obstacle.  In Skate or Die, you Died.")
        }
    }

}

// MARK: - Actions

extension GameScene {

    func tapped(gesture: UITapGestureRecognizer) {
        player.jump()
    }

}

// MARK: - Motion Methods

extension GameScene {

    func groundMovement() {
        for i in 0..<asphaltPieces.count {
            if asphaltPieces[i].position.x <= GameManager.sharedManager.GROUND_X_RESET {
                var index = i - 1
                if i == 0 {
                    index = asphaltPieces.count - 1
                }

                asphaltPieces[i].position = CGPoint(x: asphaltPieces[index].position.x + asphaltPieces[index].size.width, y: asphaltPieces[index].position.y)
            }

        }

        for i in 0..<sidewalkPieces.count {
            if sidewalkPieces[i].position.x <= GameManager.sharedManager.GROUND_X_RESET {
                var index = i - 1
                if i == 0 {
                    index = sidewalkPieces.count - 1
                }

                sidewalkPieces[i].position = CGPoint(x: sidewalkPieces[index].position.x + sidewalkPieces[index].size.width, y: sidewalkPieces[index].position.y)
            }
        }

        for i in 0..<farBG.count {
            for backgroundArray in [farBG, midBG, frontBG] {
                if backgroundArray[i].position.x <= X_RESET {
                    var index = i - 1
                    if i == 0 {
                        index = backgroundArray.count - 1
                    }

                    backgroundArray[i].position = CGPoint(x: backgroundArray[index].position.x + backgroundArray[index].size.width, y: backgroundArray[index].position.y)
                }
            }
        }
    }
}