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
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        let player = Player()
        
        entityManager = EntityManager(scene: self)
        entityManager.add(player)
        
        playerSystem = PlayerSystem(scene: self, player: Player())
        playerSystem.idle()
    }

    func touchDown(atPoint pos : CGPoint) {
        playerSystem.rotate()
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        // movement actions
    }
    
    func touchUp(atPoint pos : CGPoint) {
        playerSystem.idle()
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
