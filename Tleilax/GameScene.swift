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
    
    private var lastUpdateTime : TimeInterval = 0
    private let player = Player()
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        entityManager = EntityManager(scene: self)
        entityManager.add(player)
    }

    func touchDown(atPoint pos : CGPoint) {
        if let stateComponent = player.component(ofType: StateComponent.self),
            (stateComponent.state?.canEnterState(RotationState.self))!
        {
            stateComponent.state?.enter(RotationState.self)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        // movement actions
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let stateComponent = player.component(ofType: StateComponent.self),
            (stateComponent.state?.canEnterState(IdleState.self))!
        {
            stateComponent.state?.enter(IdleState.self)
        }
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
        }
        
        self.lastUpdateTime = currentTime
    }
}
