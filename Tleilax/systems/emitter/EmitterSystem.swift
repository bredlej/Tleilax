//
//  EmitterSystem.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 07.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit
import SpriteKit

extension Notification.Name {
    static let emit = Notification.Name("emit")
}
class EmitterSystem: GKComponentSystem<EmitterComponent> {
    
    override init() {
        super.init()
    }
}
