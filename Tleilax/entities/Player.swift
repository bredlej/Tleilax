//
//  Player.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class Player: GKEntity {

    override init() {
        super.init()
        
        let idleState = IdleState(entity: self)
        let rotationState = RotationState(entity: self)
        let stateComponent = StateComponent([idleState, rotationState])
        let idleAnimationComponent = AnimationComponent(stateToTextureMap: [idleState: SKTextureAtlas(named: "shipAnim"),
                                                                            rotationState: SKTextureAtlas(named: "shipRotation")])
        let spriteComponent = SpriteComponent(texture: (idleAnimationComponent.frames[idleState]?.first!)!)
        
        stateComponent.state?.enter(IdleState.self)
    
        addComponent(idleAnimationComponent)
        addComponent(spriteComponent)
        addComponent(stateComponent)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
