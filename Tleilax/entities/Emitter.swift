//
//  Emitter.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 07.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class Emitter : GKEntity {
   
    init(birthRatePerSecond: Int, texture: String) {
        super.init()
        addComponent(BirthRateComponent(birthRate: birthRatePerSecond))
        addComponent(DirectionComponent(direction: CGPoint(x: 0.0, y: 1.0)))
        addComponent(SpriteComponent(texture: SKTexture(imageNamed: texture)))
        addComponent(StateComponent([EmitState(), StopEmitState()]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
