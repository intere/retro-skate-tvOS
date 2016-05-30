//
//  IntroScene.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class IntroScene: BaseScene {

    let player = Player()
    var introEnded = false

    class func createScene() -> IntroScene? {
        return IntroScene(fileNamed: "IntroScene")
    }

    override func didMoveToView(view: SKView) {
        setupTitle()
        setupButton()
        setupBackground()
        setupActors()
        beginSimulation()

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        self.view?.addGestureRecognizer(tap)
    }

    override func update(currentTime: CFTimeInterval) {
        ScrollingSceneryManager.sharedManager.update()
        for node in children {
            node.update()
        }
    }
}

// MARK: - Actions

extension IntroScene {

    func tapped(gesture: UITapGestureRecognizer) {
        introEnded = true
        guard let gameScene = GameScene.createScene() else {
            return
        }

        gameScene.scaleMode = .AspectFill
        view?.presentScene(gameScene, transition: SKTransition.crossFadeWithDuration(1))

    }

}

// MARK: - Helpers

private extension IntroScene {

    func setupTitle() {
        let title = SKSpriteNode(texture: TextureManager.sharedManager.titleTexture)
        title.position = CGPoint(x: 500, y: 600)
        addChild(title)
    }

    func setupButton() {
        let button = SKSpriteNode(texture: TextureManager.sharedManager.playTexture)
        button.position = CGPoint(x: 500, y: 450)
        addChild(button)
    }

    func setupBackground() {
        SceneryManager.sharedManager.createAsphalt(self)
        SceneryManager.sharedManager.createSidewalk(self)
    }

    func setupActors() {
        player.zPosition = 10

        player.position = CGPoint(x: 100, y: 180)
        addChild(player)
    }

    func beginSimulation() {
        guard !introEnded else {
            return
        }
        
        let action = arc4random_uniform(4)
        switch action {
        case 0:
            addHydrant()

        case 1:
            addLedge()

        case 2:
            addDumpster()

        case 3:
            addRail()

        default:
            print("Invalid Action:", action)
        }

        runAction(SKAction.sequence([SKAction.waitForDuration(4), SKAction.runBlock {
            self.beginSimulation()
        }]))
    }

    func addLedge() {
        let ledge = Ledge()
        addChild(ledge)
        ledge.removeOnExceed = true
        ledge.startMoving()
        ledge.position = CGPoint(x: 1200, y: ledge.yPos)

        waitThenJump(2)
        waitThenJump(2.8)
    }

    func addHydrant() {
        let hydrant = FireHydrant()
        addChild(hydrant)
        hydrant.removeOnExceed = true
        hydrant.startMoving()
        hydrant.position = CGPoint(x: 1200, y: hydrant.yPos)

        waitThenJump(2.3)
    }

    func addDumpster() {
        let dumpster = Dumpster()
        dumpster.removeOnExceed = true
        addChild(dumpster)
        dumpster.startMoving()
        dumpster.position = CGPoint(x: 1200, y: dumpster.yPos)
        waitThenJump(2)
    }

    func addRail() {
        let rail = Rail()
        rail.removeOnExceed = true
        addChild(rail)
        rail.startMoving()
        rail.position = CGPoint(x: 1200, y: rail.yPos)
        waitThenJump(1.7)
        waitThenHardflip(2.6)
    }

    func waitThenJump(wait: NSTimeInterval) {
        waitThenDo(wait) { 
            self.player.jump()
        }
    }

    func waitThenHardflip(wait: NSTimeInterval) {
        waitThenDo(wait) { 
            self.player.jump()
            self.waitThenDo(0.25) {
                self.player.hardflip()
            }
        }
    }

    func waitThenDo(wait: NSTimeInterval, block: Block) {
        runAction(SKAction.waitForDuration(wait)) {
            block()
        }
    }

}
