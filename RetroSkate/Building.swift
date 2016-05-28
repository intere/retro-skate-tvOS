//
//  Building.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/28/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class Building: Moveable {

    convenience init() {
        self.init(texture: TextureManager.sharedManager.randomBuildingTexture)
        anchorPoint = CGPoint(x: 0.5, y: 0)
        yPos = 200
        zPosition = 5
    }

    override func didExceedBounds() {
        super.didExceedBounds()
        self.texture = TextureManager.sharedManager.randomBuildingTexture
    }

}
