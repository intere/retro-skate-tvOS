//
//  Sidewalk.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/28/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Sidewalk: SKSpriteNode {

    convenience init() {
        self.init(texture: TextureManager.sharedManager.sidewalkTexture)
        zPosition = 5
    }

}
