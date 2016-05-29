//
//  GameManager.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class GameManager {
    static let sharedManager = GameManager()

    let GROUND_SPEED: CGFloat = -8.5
    let GROUND_X_RESET: CGFloat = -150

    var score = 0
    var distance = 0
    
}
