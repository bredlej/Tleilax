//
//  Player.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class IdleState : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is RotationState.Type
    }
}

class RotationState : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is IdleState.Type
    }
}

class Player: GKEntity {

    var stateAnimations : [GKState:SKTextureAtlas]?
    
    init(_ atlasName: String) {
        super.init()
        let idleState = IdleState()
        let rotationState = RotationState()
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
