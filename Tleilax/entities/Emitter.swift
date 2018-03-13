//
//  Emitter.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 07.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class Emitter : GKEntity {
   
    init(id: Int, birthRatePerSecond: Double, texture: String) {
        super.init()
        addComponent(SpriteComponent(texture: SKTexture(imageNamed: texture)))
        addComponent(StateComponent([EmitState(), StopEmitState()]))
        addComponent(EmitterComponent(id: id, birthRate: birthRatePerSecond))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
