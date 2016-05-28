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

    // Animations
    var skaterPushTextures = TextureManager.loadTextures("push", startIndex: 0, endIndex: 11)
    var skaterCrashTextures = TextureManager.loadTextures("crash", startIndex: 0, endIndex: 8)

    // Buildings
    private var buildingTextures = TextureManager.loadTextures("building", startIndex: 0, endIndex: 7)

    
    var randomBuildingTexture: SKTexture {
        return buildingTextures[Int(arc4random_uniform(8))]
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