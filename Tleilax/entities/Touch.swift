//
//  Touch.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 06.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit
import SpriteKit

class Touch: GKEntity {

    override init() {
        super.init()
        addComponent(NodeComponent())
        addComponent(DirectionComponent(direction: CGVector(dx: 0.0, dy: 0.0)))
        addComponent(StateComponent([TouchPressed(), TouchMoved(), TouchReleased()]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
