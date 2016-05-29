//
//  DumpsterTop.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/28/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class RideableTop: Rideable {

    convenience init() {
        self.init(size: CGSize(width: 100, height: 5))
    }

    convenience init(size: CGSize) {
        self.init(color: UIColor.clearColor(), size: size)
        yPos = 220
        zPosition = 6
    }

}
