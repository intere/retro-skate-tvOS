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

    override func didMoveToView(view: SKView) {
        GameManager.sharedManager.playerDead = false
        CollisionManager.sharedManager.scene = self

        setupBackground()
        setupGround()

        setupActions()

        player = Player()
        addChild(player)

        setupObstacles()

        setupPhysics()
//        playLevelMusic()

        randomlySpawnCoin()
    }

}

// MARK: - Game Loop

extension GameScene {

    override func update(currentTime: CFTimeInterval) {

        ScrollingSceneryManager.sharedManager.update()

        for child in children {
            child.update()
        }

        DistanceManager.sharedManager.update()
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

        let hud = HeadsUpDisplay()
        hud.position = CGPoint(x: 500, y: 600)
        addChild(hud)
    }

    func setupGround() {
        var asphaltPieces = [Asphalt]()

        for _ in 0..<ASP_PIECES {
            let asphalt = Asphalt()
            asphaltPieces.append(asphalt)
            addChild(asphalt)
        }
        DistanceManager.sharedManager.node = asphaltPieces.first!
        ScrollingSceneryManager.sharedManager.addScrollingScenery(asphaltPieces, startPosition: CGPoint(x: 0, y: GameManager.sharedManager.ASPHALT_X_RESET), resetXPosition: GameManager.sharedManager.GROUND_X_RESET, moveSpeed: GameManager.sharedManager.GROUND_SPEED)

        var sidewalkPieces = [Sidewalk]()

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
        addChild(dumpster.top)
        dumpster.startMoving()

        let hydrant = FireHydrant()
        addChild(hydrant)
        hydrant.startMoving()

        let rail = Rail()
        addChild(rail)
        addChild(rail.top)
        rail.startMoving()

        let ledge = Ledge()
        addChild(ledge)
        addChild(ledge.top)
        ledge.startMoving()

        waitAndRunBlock(5, repititions: 3) {
            let building = Building()
            self.addChild(building)
            building.startMoving()
        }

        waitAndRunBlock(3, repititions: 2) {
            let tree = Tree()
            self.addChild(tree)
            tree.startMoving()
        }

        waitAndRunBlock(3, repititions: 3) {
            let cloud = Cloud()
            self.addChild(cloud)
            cloud.startMoving()
        }
    }

    typealias Block = () -> Void

    func waitAndRunBlock(maxWait: NSTimeInterval, repititions: Int, block: Block ) {
        for i in 0..<repititions {
            let wait = Double(arc4random_uniform(UInt32(maxWait*1000))) / Double(1000)
            let waitAction = SKAction.waitForDuration(NSTimeInterval(i+1) * wait)
            runAction(waitAction) {
                guard GameManager.sharedManager.isPlayerAlive() else {
                    return
                }
                block()
            }
        }
    }

    func setupActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        view?.addGestureRecognizer(tap)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipe.direction = .Up
        view?.addGestureRecognizer(swipe)
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
        CollisionManager.sharedManager.handleCollision(contact)
    }

}

// MARK: - Actions

extension GameScene {

    func tapped(gesture: UITapGestureRecognizer) {
        guard GameManager.sharedManager.isPlayerAlive() else {
            return
        }

        player.jump()
    }

    func swiped(gesture: UISwipeGestureRecognizer) {
        guard GameManager.sharedManager.isPlayerAlive() else {
            return
        }
        player.hardflip()
    }

}


// MARK: - Helpers

private extension GameScene {

    func randomlySpawnCoin() {
        guard GameManager.sharedManager.isPlayerAlive() else {
            return
        }

        let randomWait = SKAction.waitForDuration(NSTimeInterval(arc4random_uniform(5) + 1))
        let action = SKAction.runBlock {
            self.spawnCoin()
            self.randomlySpawnCoin()
        }
        runAction(SKAction.sequence([randomWait, action]))
    }

    func spawnCoin() {
        guard GameManager.sharedManager.isPlayerAlive() else {
            return
        }
        let coin = Coin()
        coin.randomizePosition()
        addChild(coin)
        coin.startMoving()
    }

}