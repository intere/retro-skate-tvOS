//
//  SceneryManager.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/30/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class SceneryManager {
    static let sharedManager = SceneryManager()

    let ASPHALT_PIECES = 15
    let SIDEWALK_PIECES = 24
    
}


// MARK: - API

extension SceneryManager {

    func createAsphalt(scene: SKScene) {
        var asphaltPieces = [Asphalt]()

        for _ in 0..<ASPHALT_PIECES {
            let asphalt = Asphalt()
            asphaltPieces.append(asphalt)
            scene.addChild(asphalt)
        }
        DistanceManager.sharedManager.node = asphaltPieces.first!
        ScrollingSceneryManager.sharedManager.addScrollingScenery(asphaltPieces, startPosition: CGPoint(x: 0, y: GameManager.sharedManager.ASPHALT_X_RESET), resetXPosition: GameManager.sharedManager.GROUND_X_RESET, moveSpeed: GameManager.sharedManager.GROUND_SPEED)
    }

    func createSidewalk(scene: SKScene) {
        var sidewalkPieces = [Sidewalk]()

        for _ in 0..<SIDEWALK_PIECES {
            let sidewalk = Sidewalk()
            sidewalkPieces.append(sidewalk)
            scene.addChild(sidewalk)
        }
        ScrollingSceneryManager.sharedManager.addScrollingScenery(sidewalkPieces, startPosition: CGPoint(x: 0, y: 190), resetXPosition: GameManager.sharedManager.GROUND_X_RESET, moveSpeed: GameManager.sharedManager.GROUND_SPEED)
    }

}