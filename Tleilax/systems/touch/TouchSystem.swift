//
//  TouchSystem.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 06.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit
import SpriteKit
import Foundation

extension Notification.Name {
    static let touchPressed = Notification.Name("touchPressed")
    static let touchMoved = Notification.Name("touchMoved")
    static let touchReleased = Notification.Name("touchReleased")
}
class TouchSystem {

    let entityManager: EntityManager

    private let touch: Touch
    private var _position : CGPoint
    private let nc = NotificationCenter.default
    
    var position : CGPoint? {
        set {
            _position = (newValue)!
        }
        get {
            return _position
        }
    }
    
    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.touch = Touch()
        _position = CGPoint(x: 0.0, y: 0.0)
    }
    
    func touchPressed(position: CGPoint) {
        if let stateComponent = touch.component(ofType: StateComponent.self),
            (stateComponent.state?.canEnterState(TouchPressed.self))!
        {
            entityManager.add(touch)
            _position = position
            stateComponent.state?.enter(TouchPressed.self)
            
            // broadcast touch position to Notification Center
            nc.post(name: .touchPressed, object: nil, userInfo: ["position" : position])
        }
    }
    
    func touchMoved(toPoint position : CGPoint) {
        if let stateComponent = touch.component(ofType: StateComponent.self),
            (stateComponent.state?.canEnterState(TouchMoved.self))!
        {
            _position = position
            stateComponent.state?.enter(TouchMoved.self)
            
            // broadcast touch position to Notification Center
            nc.post(name: .touchMoved, object: position, userInfo: ["position" : position])
        }
    }
    
    func touchReleased(position: CGPoint) {
        if let stateComponent = touch.component(ofType: StateComponent.self),
            (stateComponent.state?.canEnterState(TouchReleased.self))!
        {
            entityManager.remove(touch)
            _position = position
            stateComponent.state?.enter(TouchReleased.self)
            
            // broadcast touch position to Notification Center
            nc.post(name: .touchReleased, object: position, userInfo: ["position" : position])
        }
    }
}
