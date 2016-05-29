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
    var frontBackgroundTexture = SKTexture(imageNamed: "bg1")
    var midBackgroundTexture = SKTexture(imageNamed: "bg2")
    var farBackgroundTexture = SKTexture(imageNamed: "bg3")

    // Asphalt
    var asphaltTexture = SKTexture(imageNamed: "asphalt")

    // Sidewalk
    var sidewalkTexture = SKTexture(imageNamed: "sidewalk")

    // Obstacles
    var dumpsterTexture = SKTexture(imageNamed: "dumpster")

    // Other stuff
    var coinTexture = SKTexture(imageNamed: "coin")

    // Animations
    var skaterPushTextures = TextureManager.loadTextures("push", startIndex: 0, endIndex: 11)
    var skaterCrashTextures = TextureManager.loadTextures("crash", startIndex: 0, endIndex: 8)
    var skaterHardflipTextures = TextureManager.loadTextures("hardflip", startIndex: 0, endIndex: 11)
    var skaterOllieTextures = TextureManager.loadTextures("ollie", startIndex: 0, endIndex: 9)    

    // Buildings
    private var buildingTextures = TextureManager.loadTextures("building", startIndex: 0, endIndex: 7)

    var randomBuildingTexture: SKTexture {
        let index = Int(arc4random_uniform(UInt32(buildingTextures.count)))
        return buildingTextures[index]
    }

    // Trees
    private var treeTextures = TextureManager.loadTextures("tree", startIndex: 0, endIndex: 1)

    var randomTreeTexture: SKTexture {
        let index = Int(arc4random_uniform(UInt32(treeTextures.count)))
        return treeTextures[index]
    }

    // Clouds
    private var cloudTextures = TextureManager.loadTextures("cloud", startIndex: 0, endIndex: 1)

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