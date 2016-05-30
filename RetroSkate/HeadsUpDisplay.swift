//
//  HeadsUpDisplay.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class HeadsUpDisplay: SKSpriteNode {

    static let FONT_NAME = "Comic Sans MS Bold"

    var coin = Coin()
    var coinDisplay: SKLabelNode!
    var player = Player()
    var playerDisplay: SKLabelNode!
    var distanceDisplay: SKLabelNode!

    convenience init() {
        self.init(color: UIColor.blackColor().colorWithAlphaComponent(0.3), size: CGSize(width: 400, height: 40))
        zPosition = 9
        setupChildren()
    }

}

// MARK: - Overrides

extension HeadsUpDisplay {

    override func update() {

        coinDisplay.text = "\(GameManager.sharedManager.score)"
        playerDisplay.text = "\(GameManager.sharedManager.lives)"
        distanceDisplay.text = "\(GameManager.sharedManager.distance/100) meters"

    }

}

// MARK: - Helpers

private extension HeadsUpDisplay {

    func setupChildren() {
        coin.xScale = 0.25
        coin.yScale = 0.25
        coin.position = CGPoint(x: -180, y: 0)
        addChild(coin)
        coinDisplay = createLabel("0", position: CGPoint(x: -150, y: -10))

        player.physicsBody = nil
        player.xScale = 0.25
        player.yScale = 0.25
        player.position = CGPoint(x: -80, y: 0)
        player.removeAllActions()
        addChild(player)

        playerDisplay = createLabel("9", position: CGPoint(x: -55, y: -10))
        distanceDisplay = createLabel("0 meters", position: CGPoint(x: 100, y: -10))
    }

    func createLabel(text: String, position: CGPoint) -> SKLabelNode {

        let label = SKLabelNode(text: text)
        label.position = position
        label.fontName = HeadsUpDisplay.FONT_NAME
        label.fontSize = 26

        addChild(label)
        return label

    }

}