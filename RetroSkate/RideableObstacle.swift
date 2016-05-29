//
//  RideableObstacle.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class RideableObstacle: Obstacle {
    var top: RideableTop!
    var topYOffset: CGFloat = 40

}

// MARK: - Overrides

extension RideableObstacle {

    override func update() {
        super.update()
        top.position = CGPoint(x: position.x, y: position.y + topYOffset)
    }

    override func didExceedBounds() {
        xOffset = randomXOffset()
        super.didExceedBounds()
    }

    override func startMoving() {
        super.startMoving()
        top.startMoving()
    }
    
}