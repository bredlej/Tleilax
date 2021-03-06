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
        addComponent(SpriteComponent(texture: SKTexture(imageNamed: "l.png")))
        addComponent(StateComponent([idleState, rotationState]))
        addComponent(DirectionComponent(direction: CGPoint(x: 0.0, y: 0.0)))
        addComponent(VelocityComponent(velocity: 0.0))
        addComponent(AnimationComponent(stateToTextureMap: [idleState: SKTextureAtlas(named: "redShip"),
                                                            rotationState: SKTextureAtlas(named: "shipRotation")]))
        addComponent(DirectionComponent(direction: CGPoint(x: 0.0, y: 0.0)))
        addComponent(VelocityComponent(velocity: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
