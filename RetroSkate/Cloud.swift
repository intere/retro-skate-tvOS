//
//  Cloud.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import UIKit

class Cloud: Moveable {

    convenience init() {
        self.init(texture: TextureManager.sharedManager.randomCloudTexture)
        zPosition = 4
        yPos = randomYPosition()
    }

    override func didExceedBounds() {
        yPos = randomYPosition()
        xOffset = randomXOffset()
        self.texture = TextureManager.sharedManager.randomCloudTexture
        super.didExceedBounds()
    }

}

// MARK: - Helpers

private extension Cloud {

    func randomYPosition() -> CGFloat {
        return randomFloat(400, max: 750)
    }

}