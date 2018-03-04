//
//  Player.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class Player: GKEntity {

    init(_ atlasName: String) {
        super.init()
        
        let idleAnimationComponent = AnimationComponent(textureAtlas: SKTextureAtlas(named: "shipAnim"), key: "default")
        let spriteComponent = SpriteComponent(texture: idleAnimationComponent.frames.first!)
        addComponent(idleAnimationComponent)
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
