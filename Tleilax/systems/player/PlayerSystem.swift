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

    private let entityManager: EntityManager
    private let player: Player
    private let weapon: Emitter
    private var timeSinceLastShoot: TimeInterval
    
    private let nc = NotificationCenter.default
    
    init(scene: SKScene, entityManager: EntityManager) {
        self.player = Player()
        self.weapon = Emitter(birthRatePerSecond: 4, texture: "laser.png")
        self.entityManager = entityManager
        self.timeSinceLastShoot = 0.0
        if let stateComponent = player.component(ofType: StateComponent.self) {
            stateComponent.state?.enter(IdleState.self)
        }
        if let weaponStateComponent = player.component(ofType: StateComponent.self) {
            weaponStateComponent.state?.enter(StopEmitState.self)
        }
        idle()
        resetAnimation()
        
        entityManager.add(player)
        entityManager.add(weapon)
        
        // listen to events from TouchSystem
        nc.addObserver(self, selector: #selector(self.touchPressed(notification:)), name: .touchPressed, object: nil)
        nc.addObserver(self, selector: #selector(self.touchMoved(notification:)), name: .touchMoved, object: nil)
        nc.addObserver(self, selector: #selector(self.touchReleased(notification:)), name: .touchReleased, object: nil)
    }
    
    func getPlayer() -> Player {
        return player
    }
    
    func getWeapon() -> Emitter {
        return weapon
    }
    
    func rotate(isLeftDirection: Bool) {
        if let stateComponent = player.component(ofType: StateComponent.self),
            let spriteComponent = player.component(ofType: SpriteComponent.self),
            let directionComponent = player.component(ofType: DirectionComponent.self),
            let velocityComponent = player.component(ofType: VelocityComponent.self),
            (stateComponent.state?.canEnterState(RotationState.self))!
        {
            spriteComponent.node.xScale = isLeftDirection ? 1.0 : -1.0
            directionComponent.direction?.x = isLeftDirection ? -1.0 : 1.0
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
            directionComponent.direction?.x = 0.0
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
        /*
        timeSinceLastShoot += deltaTime
        if let birthRateComponent = weapon.component(ofType: BirthRateComponent.self),
            let weaponStateComponent = weapon.component(ofType: StateComponent.self),
            let weaponSpriteComponent = weapon.component(ofType: SpriteComponent.self),
            weaponStateComponent.state?.currentState is EmitState,
            timeSinceLastShoot.isLess(than: Double( 60 / birthRateComponent.birthRate!))
        {
            let bullet = Bullet()
            if let bulletSpriteComponent = bullet.component(ofType: SpriteComponent.self) {
                bulletSpriteComponent.node.position = weaponSpriteComponent.node.position
                
            }
            entityManager.add(bullet)
        }
        
        for entity in entityManager.entities {
            if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
                if spriteComponent.node.position.y > 1400.0 {
                    entityManager.remove(entity)
                }
                else {
                    spriteComponent.node.position.y += CGFloat(50 * deltaTime)
                }
            }
        }
 */
    }
    
    @objc func touchPressed(notification: NSNotification) {
        if let touchPosition = notification.userInfo!["position"] as? CGPoint,
            let spriteComponent = player.component(ofType: SpriteComponent.self),
            let weaponStateComponent = weapon.component(ofType: StateComponent.self),
            let weaponSpriteComponent = weapon.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = touchPosition
            spriteComponent.node.position.x -= 65.0
            spriteComponent.node.position.y += 175.0

            if (weaponStateComponent.state?.canEnterState(EmitState.self))! {
                weaponStateComponent.state?.enter(EmitState.self)
                weaponSpriteComponent.node.position = spriteComponent.node.position
                weaponSpriteComponent.node.position.y += 20.0 + spriteComponent.node.size.height / 2.0
                weaponSpriteComponent.node.isHidden = false
            }
        }
    }
    
    @objc func touchMoved(notification: NSNotification) {
        if let touchPosition = notification.userInfo!["position"] as? CGPoint,
            let spriteComponent = player.component(ofType: SpriteComponent.self),
            let weaponSpriteComponent = weapon.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = touchPosition
            spriteComponent.node.position.x -= 65.0
            spriteComponent.node.position.y += 175.0
            weaponSpriteComponent.node.position = spriteComponent.node.position
            weaponSpriteComponent.node.position.y += 20.0 + spriteComponent.node.size.height / 2.0
        }
    }
    
    @objc func touchReleased(notification: NSNotification) {
        if let weaponSpriteComponent = weapon.component(ofType: SpriteComponent.self),
            let weaponStateComponent = weapon.component(ofType: StateComponent.self)
        {
            if (weaponStateComponent.state?.canEnterState(StopEmitState.self))! {
                weaponStateComponent.state?.enter(StopEmitState.self)
                weaponSpriteComponent.node.isHidden = true
            }
        }
    }
}
