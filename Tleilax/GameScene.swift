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
    private var playerNode : PlayerNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        self.playerNode = self.childNode(withName: "Player") as? PlayerNode
        self.playerNode?.initialSetup()
        self.playerNode?.isHidden = true
        
        entityManager = EntityManager(scene: self)
        let player = Player("shipAnim")
        initPlayer(player)
        entityManager.add(player)
    }
    
    func initPlayer(_ player: Player) {
        if let spriteComponent = player.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2, y: spriteComponent.node.size.height/2)
            if let animationComponent = player.component(ofType: AnimationComponent.self) {
                spriteComponent.node.run(SKAction.repeatForever(SKAction.animate(with: animationComponent.frames,
                                                                                 timePerFrame: 0.1,
                                                                                 resize: false,
                                                                                 restore: true)),
                                         withKey: animationComponent.key)
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

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
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in entityManager.entities {
            entity.update(deltaTime: dt)
        }

        
        self.lastUpdateTime = currentTime
    }
}
