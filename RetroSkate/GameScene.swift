//
//  GameScene.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright (c) 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class GameScene: BaseScene {

    var player: Player!

    class func createScene() -> GameScene? {
        return GameScene(fileNamed: "GameScene")
    }

    override func didMoveToView(view: SKView) {

        GameManager.sharedManager.resetGame()
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

        ScrollingSceneryManager.sharedManager.addScrollingScenery(frontBG, startPosition: CGPoint(x: 0, y: 400), resetXPosition: GameManager.sharedManager.BACKGROUND_X_RESET, moveSpeed: -2)
        ScrollingSceneryManager.sharedManager.addScrollingScenery(midBG, startPosition: CGPoint(x: 0, y: 450), resetXPosition: GameManager.sharedManager.BACKGROUND_X_RESET, moveSpeed: -1)
        ScrollingSceneryManager.sharedManager.addScrollingScenery(farBG, startPosition: CGPoint(x: 0, y: 500), resetXPosition: GameManager.sharedManager.BACKGROUND_X_RESET, moveSpeed: -0.5)

        let hud = HeadsUpDisplay()
        hud.position = CGPoint(x: 500, y: 600)
        addChild(hud)
    }

    func setupGround() {
        SceneryManager.sharedManager.createAsphalt(self)
        SceneryManager.sharedManager.createSidewalk(self)
    }

    func setupObstacles() {
        let dumpster = Dumpster()
        addChild(dumpster)
        dumpster.startMoving()

        let hydrant = FireHydrant()
        addChild(hydrant)
        hydrant.startMoving()

        let rail = Rail()
        addChild(rail)
        rail.startMoving()

        let ledge = Ledge()
        addChild(ledge)
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

    func setupActions() {

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        view?.addGestureRecognizer(tap)

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipe.direction = .Up
        view?.addGestureRecognizer(swipe)
        
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
        if GameManager.sharedManager.isPlayerAlive() {
            player.jump()
        } else if GameManager.sharedManager.gameOverTimerExpired {
            showIntro()
        }
    }

    func swiped(gesture: UISwipeGestureRecognizer) {
        guard GameManager.sharedManager.isPlayerAlive() else {
            return
        }
        player.hardflip()
    }

}

// MARK: - API

extension GameScene {

    func handleGameOver() {
        runAction(SKAction.waitForDuration(1)) {
            self.playGameOverSound()
            self.showGameOver()
        }

    }

    func stopPlayLevelMusic() {
        AudioManager.sharedManager.stopLevelMusic()
    }

}


// MARK: - Helpers

private extension GameScene {

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

    func playLevelMusic() {
        AudioManager.sharedManager.playLevelMusic()
    }

    func playGameOverSound() {
        runAction(SKAction.playSoundFileNamed("sfxGameOver.wav", waitForCompletion: false))
    }

    func showGameOver() {

        let startPoint = CGPoint(x: 2000, y: 400)
        let endPoint = CGPoint(x: 530, y: 400)

        let gameOverNode = SKSpriteNode(color: UIColor.blackColor().colorWithAlphaComponent(0.8), size: CGSize(width: 800, height: 300))
        gameOverNode.position = startPoint
        gameOverNode.zPosition = 11


        let gameOverText = SKSpriteNode(texture: TextureManager.sharedManager.gameOverTexture)
        gameOverText.position = CGPoint(x: 0, y: 0)

        gameOverNode.addChild(gameOverText)
        addChild(gameOverNode)

        gameOverNode.runAction(SKAction.moveTo(endPoint, duration: 2)) {
            GameManager.sharedManager.gameOverTimerExpired = true
        }

    }

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

    func showIntro() {
        guard let scene = IntroScene.createScene() else {
            return
        }

        scene.scaleMode = .AspectFill
        view?.presentScene(scene, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: 2))
    }

}