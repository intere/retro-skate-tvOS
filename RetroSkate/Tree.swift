//
//  Tree.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Tree: Moveable {

    convenience init() {
        self.init(texture: TextureManager.sharedManager.randomTreeTexture)
        zPosition = 5.1
        anchorPoint = CGPoint(x: 0.5, y: 0)
        yPos = 200
    }

    override func didExceedBounds() {
        xOffset = randomXOffset()
        self.texture = TextureManager.sharedManager.randomTreeTexture
        super.didExceedBounds()
    }

}
