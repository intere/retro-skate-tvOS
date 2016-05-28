//
//  ScrollingSceneryManager.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/28/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//


import SpriteKit

class ScrollingSceneryManager {
    static let sharedManager = ScrollingSceneryManager()

    static let DURATION = 0.02

    private var sceneryList = [SceneryType]()


}

// MARK: - Public Interface

extension ScrollingSceneryManager {

    func addScrollingScenery(tiles: [SKSpriteNode], startPosition: CGPoint, resetXPosition: CGFloat, moveSpeed: CGFloat) {

        configureScenery(tiles, startPosition: startPosition, resetXPosition: resetXPosition, moveSpeed: moveSpeed)
    }

    func update() {
        shiftSceneryTiles()
    }

}

// MARK: - Helpers
private extension ScrollingSceneryManager {

    func shiftSceneryTiles() {
        for scenery in sceneryList {
            for i in 0..<scenery.tiles.count {
                if scenery.tiles[i].position.x <= scenery.resetXPosition {
                    let index = (i==0) ? scenery.tiles.count-1 : i-1
                    let xPosition = scenery.tiles[index].position.x + scenery.tiles[index].size.width
                    scenery.tiles[i].position = CGPoint(x: xPosition
                        , y: scenery.tiles[index].position.y)
                }
            }
        }
    }

    func configureScenery(tiles: [SKSpriteNode], startPosition: CGPoint, resetXPosition: CGFloat, moveSpeed: CGFloat) {

        let moveAction = SKAction.moveByX(moveSpeed, y: 0, duration: ScrollingSceneryManager.DURATION)
        let moveForeverAction = SKAction.repeatActionForever(moveAction)

        sceneryList.append(SceneryType(tiles: tiles, moveSpeed: moveSpeed, startPosition: startPosition, resetXPosition: resetXPosition, foreverAction: moveForeverAction))

        for i in 0..<tiles.count {
            let position = CGPoint(x: startPosition.x + CGFloat(i) * tiles[i].size.width, y: startPosition.y)
            tiles[i].position = position
            tiles[i].runAction(moveForeverAction)
        }
    }

    /// Internal Data Type
    struct SceneryType {
        var tiles: [SKSpriteNode]!
        var moveSpeed: CGFloat
        var startPosition: CGPoint
        var resetXPosition: CGFloat
        var foreverAction: SKAction!
    }

}
