//
//  GameManager.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

typealias Block = () -> Void

class GameManager {
    static let sharedManager = GameManager()

    // MARK: Game Configuration Values
    let GROUND_SPEED: CGFloat = -8.5
    let GROUND_X_RESET: CGFloat = -150
    let ASPHALT_X_RESET: CGFloat = 145
    let BACKGROUND_X_RESET: CGFloat = -912

    // MARK: Defaults
    static let START_LIVES = 1  // TODO - change this back to 5

    // MARK: Game State
    var score = 0
    var distance = 0
    var lives = GameManager.START_LIVES
    var playerDead = true
    var gameOverTimerExpired = false
}

// MARK: - API

extension GameManager {

    func isPlayerAlive() -> Bool {
        return !playerDead
    }

    func resetGame() {
        score = 0
        distance = 0
        lives = GameManager.START_LIVES
        gameOverTimerExpired = false
        playerDead = false
    }

}
