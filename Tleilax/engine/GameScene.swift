//
//  GameScene.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import SpriteKit
import GameplayKit

extension CGPoint {
    
    public enum CoordinateSystem {
        case UIKit
        case SpriteKit
    }
    
    public func coordinates(from: CoordinateSystem, to: CoordinateSystem) -> CGPoint {
        if from == to { return self }
        else  {
            return CGPoint(x: self.x, y: -self.y)
        }
    }
}

public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func +=( lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
}

public func -=( lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
}

class GameScene: SKScene {
    
    var graphs = [String : GKGraph]()
    var entityManager: EntityManager!
    var playerSystem: PlayerSystem!
    var touchSystem: TouchSystem!
    var enemySystem: EnemySystem!
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        entityManager = EntityManager(scene: self)
        playerSystem = PlayerSystem(scene: self, entityManager: entityManager)
        playerSystem.resetAnimation()
        touchSystem = TouchSystem(entityManager: entityManager)
        enemySystem = EnemySystem(scene: self, entityManager: entityManager)
        enemySystem.addEnemy(position: CGPoint(x: 50.0, y: 500.0))
        print("Create scene \(self.size)")
    }

    func touchDown(atPoint pos : CGPoint) {
        touchSystem.touchPressed(position: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        touchSystem.touchMoved(toPoint: pos)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        touchSystem.touchReleased(position: pos)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {

        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        let dt = currentTime - self.lastUpdateTime
        
        for entity in entityManager.entities {
            entity.update(deltaTime: dt)
            updateBullets(entity, dt)
        }
        
        playerSystem.update(deltaTime: dt)
        
        self.lastUpdateTime = currentTime
    }
    
    fileprivate func updateBullets(_ entity: GKEntity, _ dt: Double) {
        if let spriteComponent = entity.component(ofType: SpriteComponent.self),
            let _ = entity.component(ofType: BulletComponent.self)
        {
            spriteComponent.node.position.y += CGFloat(dt)+10.0*3.0
            if spriteComponent.node.position.y > 700.0 {
                entityManager.remove(entity)
            }
        }
    }
}
