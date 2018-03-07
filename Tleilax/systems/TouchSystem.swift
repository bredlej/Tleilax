//
//  TouchSystem.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 06.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit
import SpriteKit

class TouchSystem {

    let scene: SKScene
    let entityManager: EntityManager

    private let touch: Touch
    private var _position : CGPoint
    
    var position : CGPoint? {
        set {
            _position = (newValue)!
        }
        get {
            return _position
        }
    }
    
    init(scene: SKScene, entityManager: EntityManager) {
        self.scene = scene
        self.entityManager = entityManager
        self.touch = Touch()
        _position = CGPoint(x: 0.0, y: 0.0)
    }
    
    func touchPressed(position: CGPoint) {
        if let stateComponent = touch.component(ofType: StateComponent.self),
            (stateComponent.state?.canEnterState(TouchPressed.self))!
        {
            entityManager.add(touch)
            let touchNode = SKNode()
            touchNode.position = position
            touchNode.name = "TouchNode"
            _position = position
            stateComponent.state?.enter(TouchPressed.self)
        }
    }
    
    func touchReleased(position: CGPoint) {
        if let stateComponent = touch.component(ofType: StateComponent.self),
            (stateComponent.state?.canEnterState(TouchReleased.self))!
        {
            entityManager.remove(touch)
            _position = position
            stateComponent.state?.enter(TouchReleased.self)
        }
    }
}
