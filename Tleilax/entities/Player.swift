//
//  Player.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class Player: GKEntity {

    var stateAnimations : [GKState:SKTextureAtlas]?
    
    override init() {
        super.init()
        let idleState = IdleState(entity: self)
        let rotationState = RotationState(entity: self)
        stateAnimations = [idleState: SKTextureAtlas(named: "shipAnim"),
                           rotationState: SKTextureAtlas(named: "shipRotation")]
        let idleAnimationComponent = AnimationComponent(stateToTextureMap: stateAnimations!)
        let spriteComponent = SpriteComponent(texture: (idleAnimationComponent.frames[idleState]?.first!)!)
        let stateComponent = StateComponent([idleState, rotationState])
        stateComponent.state?.enter(IdleState.self)
        
        addComponent(idleAnimationComponent)
        addComponent(spriteComponent)
        addComponent(stateComponent)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
