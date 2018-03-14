//
//  Enemy.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 13.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class Enemy: GKEntity {
    
    init(texture: SKTexture) {
        super.init()
        let idleState = IdleState()
        addComponent(SpriteComponent(texture: texture))
        addComponent(StateComponent([idleState]))
        addComponent(AnimationComponent(stateToTextureMap: [idleState: SKTextureAtlas(named: "enemy")]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
