//
//  DistanceCalculator.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit

class DistanceManager {
    static let sharedManager = DistanceManager()

    var node: Asphalt!

    var distance: Int = 0
    var lastX: CGFloat = -123456

}

// MARK: - API 

extension DistanceManager {

    func update() {
        guard let node = node else {
            print("I'm not configured correctly, I don't have an Asphalt Node")
            return
        }

        guard Int(lastX) != Int(-123456) else {
            lastX = node.position.x
            return
        }

        if lastX < 0 && node.position.x > 0 {
            let leftDeltaX = abs(GameManager.sharedManager.GROUND_X_RESET - lastX)
            assert(leftDeltaX >= 0)

            let rightDeltaX = abs(GameManager.sharedManager.GROUND_X_RESET - node.position.x)
            assert(rightDeltaX >= 0)

            distance += Int(leftDeltaX + rightDeltaX)
        } else {
            let deltaX = abs(node.position.x - lastX)
            assert(deltaX >= 0)

            distance += Int(deltaX)
        }
        
        lastX = node.position.x
    }

}
