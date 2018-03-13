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

    private let _player: Player
    private let _entityManager: EntityManager
    private let _weaponEmitterSystem: WeaponSystem
    
    private let nc = NotificationCenter.default
    
    init(scene: SKScene, entityManager: EntityManager) {
        self._player = Player()
        self._entityManager = entityManager
        self._weaponEmitterSystem = WeaponSystem(scene: scene, entityManager: entityManager, offsetPosition: CGPoint(x: 0.0, y: 50.0))
        initPlayerWeapons()
        
        if let stateComponent = _player.component(ofType: StateComponent.self) {
            stateComponent.state?.enter(IdleState.self)
        }
        
        resetAnimation()
        
        entityManager.add(_player)
        
        // listen to events from TouchSystem
        nc.addObserver(self, selector: #selector(self.touchPressed(notification:)), name: .touchPressed, object: nil)
        nc.addObserver(self, selector: #selector(self.touchMoved(notification:)), name: .touchMoved, object: nil)
        nc.addObserver(self, selector: #selector(self.touchReleased(notification:)), name: .touchReleased, object: nil)
    }
    
    fileprivate func initPlayerWeapons() {
        /*self._weaponEmitterSystem.addWeapon(id: 1, bullet: Bullet(bulletType: BulletType.large, initialPosition: CGPoint(x: -15.0, y: 20.0)+(_player.component(ofType: SpriteComponent.self)?.node.position)!), birthRate: 3)
        self._weaponEmitterSystem.addWeapon(id: 2, bullet: Bullet(bulletType: BulletType.large, initialPosition: CGPoint(x: 15.0, y: 20.0)+(_player.component(ofType: SpriteComponent.self)?.node.position)!), birthRate: 3)
        
        self._weaponEmitterSystem.addWeapon(id: 3, bullet: Bullet(bulletType: BulletType.normal, initialPosition: CGPoint(x: -50.0, y: 5.0)+(_player.component(ofType: SpriteComponent.self)?.node.position)!), birthRate: 4)
        self._weaponEmitterSystem.addWeapon(id: 4, bullet: Bullet(bulletType: BulletType.normal, initialPosition: CGPoint(x: 50.0, y: 5.0)+(_player.component(ofType: SpriteComponent.self)?.node.position)!), birthRate: 4)
        */
        self._weaponEmitterSystem.addWeapon(id: 5, bullet: Bullet(bulletType: BulletType.normal, initialPosition: CGPoint(x: -70.0, y: -25.0)+(_player.component(ofType: SpriteComponent.self)?.node.position)!), birthRate: 8)
        self._weaponEmitterSystem.addWeapon(id: 6, bullet: Bullet(bulletType: BulletType.normal, initialPosition: CGPoint(x: 70.0, y: -25.0)+(_player.component(ofType: SpriteComponent.self)?.node.position)!), birthRate: 8)
        self._weaponEmitterSystem.stopShooting()
    }
    
    func getPlayer() -> Player {
        return _player
    }

    func resetAnimation() {
        if let spriteComponent = _player.component(ofType: SpriteComponent.self),
            let animationComponent = _player.component(ofType: AnimationComponent.self),
            let stateComponent = _player.component(ofType: StateComponent.self)
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
        _weaponEmitterSystem.originPosition = (_player.component(ofType: SpriteComponent.self)?.node.position)!
        _weaponEmitterSystem.update(deltaTime: deltaTime)
    }
    
    @objc func touchPressed(notification: NSNotification) {
        if let touchPosition = notification.userInfo!["position"] as? CGPoint,
            let spriteComponent = _player.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = touchPosition
            spriteComponent.node.position.y += 75.0

            _weaponEmitterSystem.originPosition = spriteComponent.node.position + _weaponEmitterSystem.offsetPosition
            _weaponEmitterSystem.startShooting()
        }
    }
    
    @objc func touchMoved(notification: NSNotification) {
        if let touchPosition = notification.userInfo!["position"] as? CGPoint,
            let spriteComponent = _player.component(ofType: SpriteComponent.self),
            let stateComponent = _player.component(ofType: StateComponent.self)
        {
            if (stateComponent.state?.canEnterState(RotationState.self))!,
                touchPosition.x < spriteComponent.node.position.x
            {
                stateComponent.state?.enter(RotationState.self)
            }
            else if (stateComponent.state?.canEnterState(RotationState.self))!,
                touchPosition.x < spriteComponent.node.position.x
            {
                stateComponent.state?.enter(RotationState.self)
                spriteComponent.node.xScale = -1.0
            }
            else if (stateComponent.state?.canEnterState(IdleState.self))! {
                stateComponent.state?.enter(IdleState.self)
                spriteComponent.node.xScale = 1.0
            }
            spriteComponent.node.position = touchPosition
            spriteComponent.node.position.y += 75.0
            
            _weaponEmitterSystem.originPosition = spriteComponent.node.position
        }
    }
    
    @objc func touchReleased(notification: NSNotification) {
        if let stateComponent = _player.component(ofType: StateComponent.self)
        {
            if (stateComponent.state?.canEnterState(IdleState.self))! {
                stateComponent.state?.enter(IdleState.self)
            }
            _weaponEmitterSystem.stopShooting()
        }
    }
}
