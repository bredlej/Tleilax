//
//  PlayerSystem.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 05.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerSystem: NSObject {

    let scene: SKScene
    private let player: Player
    
    init(scene: SKScene) {

        self.scene = scene
        self.player = Player()
        if let stateComponent = player.component(ofType: StateComponent.self) {
            stateComponent.state?.enter(IdleState.self)
        }
    }
    
    func getPlayer() -> Player {
        return player
    }
    
    func rotate(isLeftDirection: Bool) {
        if let stateComponent = player.component(ofType: StateComponent.self),
            let spriteComponent = player.component(ofType: SpriteComponent.self),
            (stateComponent.state?.canEnterState(RotationState.self))!
        {
            spriteComponent.node.xScale = isLeftDirection ? 1.0 : -1.0
            stateComponent.state?.enter(RotationState.self)
            resetAnimation()
        }
    }
    
    func idle() {
        if let stateComponent = player.component(ofType: StateComponent.self),
            (stateComponent.state?.canEnterState(IdleState.self))!
        {
            stateComponent.state?.enter(IdleState.self)
            resetAnimation()
        }
    }
    
    func resetAnimation() {
        if let spriteComponent = player.component(ofType: SpriteComponent.self),
            let animationComponent = player.component(ofType: AnimationComponent.self),
            let stateComponent = player.component(ofType: StateComponent.self)
        {
            spriteComponent.node.removeAllActions()
            spriteComponent.node.run(SKAction.repeatForever(SKAction.animate(with: animationComponent.frames[(stateComponent.state?.currentState)!]!,
                                                                             timePerFrame: 0.1,
                                                                             resize: false,
                                                                             restore: true)),
                                     withKey: "idle")
        }
    }
}
