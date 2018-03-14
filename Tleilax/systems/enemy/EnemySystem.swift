//
//  EnemySystem.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 13.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import SpriteKit
import GameplayKit

class EnemySystem {
    
    private var _scene: SKScene
    private var _entityManager: EntityManager
    
    init(scene: SKScene, entityManager: EntityManager) {
        _scene = scene
        _entityManager = entityManager
    }
    
    func addEnemy(position: CGPoint) {
        let enemy: Enemy = Enemy(texture: SKTexture(imageNamed: "2.png"))
        enemy.component(ofType: SpriteComponent.self)?.node.position = position
        enemy.component(ofType: StateComponent.self)?.state?.enter(IdleState.self)
        if let spriteComponent = enemy.component(ofType: SpriteComponent.self),
            let animationComponent = enemy.component(ofType: AnimationComponent.self),
            let stateComponent = enemy.component(ofType: StateComponent.self)
        {
            spriteComponent.node.removeAllActions()
            spriteComponent.node.xScale = 0.5
            spriteComponent.node.yScale = -0.5
            spriteComponent.node.run(SKAction.repeatForever(SKAction.animate(with: animationComponent.frames[(stateComponent.state?.currentState)!]!,
                                                                             timePerFrame: 0.1,
                                                                             resize: false,
                                                                             restore: true)),
                                     withKey: "idle")
        }
        _entityManager.add(enemy)
    }
    
    func resetAnimation() {

    }
}
