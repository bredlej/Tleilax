//
//  PlayerSystem.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 05.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class PlayerSystem {

    let scene: SKScene
    private let player: Player
    private let nc = NotificationCenter.default
    
    init(scene: SKScene) {
        self.scene = scene
        self.player = Player()
        if let stateComponent = player.component(ofType: StateComponent.self) {
            stateComponent.state?.enter(IdleState.self)
        }
        idle()
        resetAnimation()
        
        // listen to events from TouchSystem
        nc.addObserver(self, selector: #selector(self.touchPressed(notification:)), name: .touchPressed, object: nil)
        nc.addObserver(self, selector: #selector(self.touchMoved(notification:)), name: .touchMoved, object: nil)
        nc.addObserver(self, selector: #selector(self.touchReleased(notification:)), name: .touchReleased, object: nil)
    }
    
    func getPlayer() -> Player {
        return player
    }
    
    func rotate(isLeftDirection: Bool) {
        if let stateComponent = player.component(ofType: StateComponent.self),
            let spriteComponent = player.component(ofType: SpriteComponent.self),
            let directionComponent = player.component(ofType: DirectionComponent.self),
            let velocityComponent = player.component(ofType: VelocityComponent.self),
            (stateComponent.state?.canEnterState(RotationState.self))!
        {
            spriteComponent.node.xScale = isLeftDirection ? 1.0 : -1.0
            directionComponent.direction?.dx = isLeftDirection ? -1.0 : 1.0
            velocityComponent.velocity = 1.0
            stateComponent.state?.enter(RotationState.self)
            resetAnimation()
        }
    }
    
    func idle() {
        if let stateComponent = player.component(ofType: StateComponent.self),
            let velocityComponent = player.component(ofType: VelocityComponent.self),
            let directionComponent = player.component(ofType: DirectionComponent.self),
            (stateComponent.state?.canEnterState(IdleState.self))!
        {
            velocityComponent.velocity = 0.0
            directionComponent.direction?.dx = 0.0
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
    
    func update(deltaTime: TimeInterval) {
        player.update(deltaTime: deltaTime)
    }
    
    @objc func touchPressed(notification: NSNotification) {
        if let touchPosition = notification.userInfo!["position"] as? CGPoint,
            let spriteComponent = player.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = touchPosition
        }
    }
    
    @objc func touchMoved(notification: NSNotification) {
        if let touchPosition = notification.userInfo!["position"] as? CGPoint,
            let spriteComponent = player.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = touchPosition
        }
    }
    
    @objc func touchReleased(notification: NSNotification) {
        // empty for now
    }
}
