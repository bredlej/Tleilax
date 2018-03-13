//
//  WeaponSystem.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 11.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit
import SpriteKit

class WeaponSystem {

    private var _weaponBulletMap : [Int: Bullet]
    private var _emitterSystem: EmitterSystem
    private var _weapons: [Emitter]
    private var _scene: SKScene
    private var _originPosition : CGPoint
    private var _offsetPosition: CGPoint
    
    private var _entityManager : EntityManager
    
    var originPosition : CGPoint {
        set {
            _originPosition = newValue
        }
        get {
            return _originPosition
        }
    }
    
    var offsetPosition : CGPoint {
        set {
            _offsetPosition = newValue
        }
        get {
            return _offsetPosition
        }
    }
    
    private let nc = NotificationCenter.default
    
    init(scene: SKScene, entityManager: EntityManager, offsetPosition: CGPoint) {
        _weaponBulletMap = [Int: Bullet]()
        _emitterSystem = EmitterSystem(scene: scene)
        _weapons = [Emitter]()
        _scene = scene
        _originPosition = CGPoint(x: 0.0, y: 0.0)
        _entityManager = entityManager
        _offsetPosition = offsetPosition
        
         nc.addObserver(self, selector: #selector(self.emit(notification:)), name: .emit, object: nil)
    }
    
    func addWeapon(id: Int, bullet: Bullet, birthRate: Double) {
        _weaponBulletMap[id] = bullet;
        let weapon = Emitter(id: id, birthRatePerSecond: birthRate, texture: "laser.png")
        _emitterSystem.addComponent(foundIn: weapon)
        _weapons.append(weapon)
    }
  
    func update(deltaTime seconds: TimeInterval) {
        _emitterSystem.update(deltaTime: seconds)
    }
    
    @objc func emit(notification: Notification) {
        let weaponId = notification.userInfo!["id"] as! Int
        if let bullet : Bullet = _weaponBulletMap[weaponId] {
            for weapon in _weapons {
                if weapon.component(ofType: StateComponent.self)?.state?.currentState is EmitState {
                    shoot(bullet: copyBullet(bullet: bullet)!)
                }
            }
        }
    }
    
    func copyBullet(bullet: Bullet) -> Bullet? {
        var newBullet : Bullet
        if let bulletSpriteNode = bullet.component(ofType: SpriteComponent.self)?.node,
            let bulletComponent = bullet.component(ofType: BulletComponent.self)
            
        {
            var bulletType = bullet.component(ofType: BulletComponent.self)?.bulletType
            if bulletType == .small {
                bulletSpriteNode.xScale = 0.7
                bulletSpriteNode.yScale = 0.7
            }
            else if bulletType == .normal {
                bulletSpriteNode.xScale = 1.5
                bulletSpriteNode.yScale = 1.5
            }
            else if bulletType == .large {
                bulletSpriteNode.xScale = 3.0
                bulletSpriteNode.yScale = 3.0
            }
            
            bulletType = bulletType == .large ? .normal : .large
            
            newBullet = Bullet(bulletType: bulletType!, initialPosition: bulletSpriteNode.position+_offsetPosition+bulletComponent.initialPosition)
            newBullet.component(ofType: SpriteComponent.self)?.node.xScale = bulletSpriteNode.xScale
            newBullet.component(ofType: SpriteComponent.self)?.node.yScale = bulletSpriteNode.yScale
            
            return newBullet
        }
        else {
            return nil
        }
    }
    
    func startShooting() {
        for weapon in _weapons {
            if let weaponStateComponent = weapon.component(ofType: StateComponent.self)
            {
                if (weaponStateComponent.state?.canEnterState(EmitState.self))! {
                    weaponStateComponent.state?.enter(EmitState.self)
                }
            }
        }
    }
    
    func stopShooting() {
        for weapon in _weapons {
            if let weaponStateComponent = weapon.component(ofType: StateComponent.self)
            {
                if (weaponStateComponent.state?.canEnterState(StopEmitState.self))! {
                    weaponStateComponent.state?.enter(StopEmitState.self)
                }
            }
        }
    }
    
    func shoot(bullet: Bullet) {
        if let bulletSpriteNode = bullet.component(ofType: SpriteComponent.self)?.node,
            let bulletComponent = bullet.component(ofType: BulletComponent.self)
        {
            bulletSpriteNode.position = self._originPosition
            bulletSpriteNode.position.x += bulletComponent.initialPosition.x
            bulletSpriteNode.position.y += bulletComponent.initialPosition.y
            _entityManager.add(bullet)
        }
    }
}
