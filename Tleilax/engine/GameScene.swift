//
//  GameScene.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var graphs = [String : GKGraph]()
    var entityManager: EntityManager!
    var playerSystem: PlayerSystem!
    var touchSystem: TouchSystem!
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        entityManager = EntityManager(scene: self)
        playerSystem = PlayerSystem(scene: self, entityManager: entityManager)
        playerSystem.idle()
        playerSystem.resetAnimation()
        touchSystem = TouchSystem(entityManager: entityManager)
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
            if let spriteComponent = entity.component(ofType: SpriteComponent.self),
                let _ = entity.component(ofType: BulletComponent.self)
            {
                spriteComponent.node.position.y += CGFloat(dt)+10.0*3.0
                if spriteComponent.node.position.y > 700.0 {
                    entityManager.remove(entity)
                }
            }
        }
        
        playerSystem.update(deltaTime: dt)
        
        self.lastUpdateTime = currentTime
    }
}
