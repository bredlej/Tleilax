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
        let idleState = IdleState()
        let rotationState = RotationState()
        addComponent(SpriteComponent(texture: SKTexture(imageNamed: "shipAnim.atlas/ship1.png")))
        addComponent(StateComponent([idleState, rotationState]))
        addComponent(DirectionComponent(direction: CGPoint(x: 0.0, y: 0.0)))
        addComponent(VelocityComponent(velocity: 0.0))
        addComponent(AnimationComponent(stateToTextureMap: [idleState: SKTextureAtlas(named: "shipAnim"),
                                                            rotationState: SKTextureAtlas(named: "shipRotation")]))
        addComponent(LocalPositionComponent(position: CGPoint(x: 0.0, y: 0.0)))
        addComponent(DirectionComponent(direction: CGPoint(x: 0.0, y: 0.0)))
        addComponent(VelocityComponent(velocity: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
