//
//  PhysicsBody.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import UIKit
import SpriteKit

enum PhysicsBody: UInt32 {
    case Player = 0b1
    case Obstacle = 0b10
    case Rideable = 0b100
}
