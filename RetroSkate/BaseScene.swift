//
//  BaseScene.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/30/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class BaseScene: SKScene {

    override func addChild(node: SKNode) {
        if let node = node as? RideableObstacle {
            super.addChild(node)
            super.addChild(node.top)
        } else {
            super.addChild(node)
        }
    }
}
