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
    let ASPHALT_X_RESET: CGFloat = 145
    static let START_LIVES = 5

    var score = 0
    var distance = 0
    var lives = GameManager.START_LIVES
    var startTime = NSDate()
    
}

// MARK: - API

extension GameManager {

    func resetGame() {
        score = 0
        distance = 0
        lives = GameManager.START_LIVES
        startTime = NSDate()
    }

}
