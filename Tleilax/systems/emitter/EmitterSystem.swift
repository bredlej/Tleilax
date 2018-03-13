//
//  EmitterSystem.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 07.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit
import SpriteKit

extension Notification.Name {
    static let emit = Notification.Name("emit")
}
class EmitterSystem: GKComponentSystem<EmitterComponent> {
    
    private let _scene : SKScene
    private let nc = NotificationCenter.default
    private var _emitters : [EmitterComponent] = [EmitterComponent]()
    
    init(scene: SKScene) {
        _scene = scene
        super.init()
    }
    
    override func addComponent(foundIn entity: GKEntity) {
        if let emitter = entity.component(ofType: EmitterComponent.self)
        {
            _emitters.append(emitter)
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for emitterComponent : EmitterComponent in _emitters {
            emitterComponent.timeSinceLastEmit = emitterComponent.timeSinceLastEmit?.advanced(by: seconds)
            if !(emitterComponent.timeSinceLastEmit?.isLess(than: Double(1.0/emitterComponent.birthRate!)))! {
                emitterComponent.readyToEmit = true
                emitterComponent.timeSinceLastEmit = 0
            }
            if emitterComponent.readyToEmit {
                emitterComponent.emit()
                NotificationCenter.default.post(name: .emit, object: nil, userInfo: ["id" : emitterComponent.id!])
            }
        }
    }
    
    
}
