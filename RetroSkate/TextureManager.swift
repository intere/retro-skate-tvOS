//
//  TextureManager.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class TextureManager {
    static let sharedManager = TextureManager()

    // Background
    let frontBackgroundTexture = SKTexture(imageNamed: "bg1")
    let midBackgroundTexture = SKTexture(imageNamed: "bg2")
    let farBackgroundTexture = SKTexture(imageNamed: "bg3")

    // Asphalt
    let asphaltTexture = SKTexture(imageNamed: "asphalt")

    // Sidewalk
    let sidewalkTexture = SKTexture(imageNamed: "sidewalk")

    // Obstacles
    let dumpsterTexture = SKTexture(imageNamed: "dumpster")
    let fireHydrantTexture = SKTexture(imageNamed: "fire_hydrant")
    let ledgeTexture = SKTexture(imageNamed: "ledge")
    let railTexture = SKTexture(imageNamed: "rail")

    // Other stuff
    let coinTexture = SKTexture(imageNamed: "coin")

    // Animations
    let skaterPushTextures = TextureManager.loadTextures("push", startIndex: 0, endIndex: 11)
    let skaterCrashTextures = TextureManager.loadTextures("crash", startIndex: 0, endIndex: 8)
    let skaterHardflipTextures = TextureManager.loadTextures("hardflip", startIndex: 0, endIndex: 11)
    let skaterOllieTextures = TextureManager.loadTextures("ollie", startIndex: 0, endIndex: 9)

    // Buildings
    private let buildingTextures = TextureManager.loadTextures("building", startIndex: 0, endIndex: 7)

    var randomBuildingTexture: SKTexture {
        let index = Int(arc4random_uniform(UInt32(buildingTextures.count)))
        return buildingTextures[index]
    }

    // Trees
    private let treeTextures = TextureManager.loadTextures("tree", startIndex: 0, endIndex: 1)

    var randomTreeTexture: SKTexture {
        let index = Int(arc4random_uniform(UInt32(treeTextures.count)))
        return treeTextures[index]
    }

    // Clouds
    private let cloudTextures = TextureManager.loadTextures("cloud", startIndex: 0, endIndex: 1)

    var randomCloudTexture: SKTexture {
        let index = Int(arc4random_uniform(UInt32(cloudTextures.count)))
        return cloudTextures[index]
    }
}


// MARK: - Helper Methods

private extension TextureManager {

    class func loadTextures(baseName: String, startIndex: Int, endIndex: Int) -> [SKTexture] {

        var textures = [SKTexture]()

        for i in startIndex...endIndex {
            textures.append(SKTexture(imageNamed: "\(baseName)\(i)"))
        }

        return textures

    }

}