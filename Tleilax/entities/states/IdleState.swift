//
//  IdleState.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class IdleState : GKState {
    
    var entity : GKEntity?
    
    init(entity: GKEntity) {
        self.entity = entity
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is RotationState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        // sample action for state change
        // replace maybe with firing an event instead
        if let spriteComponent = entity?.component(ofType: SpriteComponent.self),
            let animationComponent = entity?.component(ofType: AnimationComponent.self)
        {
            spriteComponent.node.removeAllActions()
            spriteComponent.node.run(SKAction.repeatForever(SKAction.animate(with: animationComponent.frames[self]!,
                                                                             timePerFrame: 0.1,
                                                                             resize: false,
                                                                             restore: true)),
                                     withKey: "idle")
        }
    }
}
