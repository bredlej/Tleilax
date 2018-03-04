//
//  PlayerNode.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import SpriteKit

class PlayerNode: SKSpriteNode {

    private var laserEmitter : SKSpriteNode?
    private var flyingFrames : [SKTexture] = []
    private var rotatingFrames : [SKTexture] = []
    private var isRotatingState : Bool = false
    private var lastTouchPosition = CGPoint(x:0.0, y:0.0)
    
    private let SPEED = 2.0
    
    func initialSetup() {
        self.laserEmitter = self.childNode(withName: "//LaserEmitter") as? SKSpriteNode
        self.laserEmitter?.isHidden = true
        loadFrames()
        animate()
    }
    
    func loadFrames() {
        let flyingAtlas = SKTextureAtlas(named: "shipAnim")
        let rotatingAtlas = SKTextureAtlas(named: "shipRotation")
        
        for i in 1...flyingAtlas.textureNames.count {
            self.flyingFrames.append(flyingAtlas.textureNamed("ship\(i)"))
        }
        for i in 1...rotatingAtlas.textureNames.count {
            self.rotatingFrames.append(rotatingAtlas.textureNamed("shipRotation\(i)"))
        }
    }
    
    func animate() {
        self.run(SKAction.repeatForever(SKAction.animate(with: self.flyingFrames,
                                                         timePerFrame: 0.1,
                                                         resize: false,
                                                         restore: true)),
                 withKey: "flyingShip")
    }
    
    func rotate(left: Bool) {
        self.xScale = left ? 1.0 : -1.0
        self.run(SKAction.repeatForever(SKAction.animate(with: self.rotatingFrames,
                                                         timePerFrame: 0.1,
                                                         resize: false,
                                                         restore: true)),
                 withKey: "rotatingShip")
    }
}
