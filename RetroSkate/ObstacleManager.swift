//
//  ObstacleManager.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/30/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class ObstacleManager {
    static let sharedManager = ObstacleManager()

    var scene: BaseScene?

}

// MARK: - API

extension ObstacleManager {

    func beginSpawning(skip: Bool) {
        guard let scene = scene else {
            print("🖕 ERROR: NO Scene to spawn obstacles in")
            return
        }
        guard GameManager.sharedManager.isPlayerAlive() else {
            print("😇 I won't spawn an obstacle, the player is dead")
            return
        }

        if !skip {
            let action = arc4random_uniform(4)
            var obstacle: Obstacle?

            switch action {
            case 0:
                obstacle = spawnHydrant()

            case 1:
                obstacle = spawnLedge()

            case 2:
                obstacle = spawnDumpster()

            case 3:
                obstacle = spawnRail()

                default:
                    print("👎 Invalid Action Value: \(action)")
            }

            if let obstacle = obstacle {
                scene.addChild(obstacle)
                obstacle.startMoving()

            }
        }

        let randomInterval = NSTimeInterval(arc4random_uniform(UInt32((GameManager.sharedManager.FIRST_LEVEL_SPAWN_MAX-1) * 1000)) / 1000) + 1
        scene.runAction(SKAction.waitForDuration(randomInterval)) {
            self.beginSpawning(false)
        }
    }

}

// MARK: - Helpers

private extension ObstacleManager {

    func spawnLedge() -> Ledge {
        let ledge = Ledge()
        ledge.removeOnExceed = true
        ledge.position = CGPoint(x: 1200, y: ledge.yPos)

        return ledge
    }

    func spawnHydrant() -> FireHydrant {
        let hydrant = FireHydrant()
        hydrant.removeOnExceed = true
        hydrant.position = CGPoint(x: 1200, y: hydrant.yPos)

        return hydrant
    }

    func spawnDumpster() -> Dumpster {
        let dumpster = Dumpster()
        dumpster.removeOnExceed = true
        dumpster.position = CGPoint(x: 1200, y: dumpster.yPos)

        return dumpster
    }

    func spawnRail() -> Rail {
        let rail = Rail()
        rail.removeOnExceed = true
        rail.position = CGPoint(x: 1200, y: rail.yPos)

        return rail
    }

}
