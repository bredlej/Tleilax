//
//  EmitterComponent.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 08.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class EmitterComponent: GKComponent {
 
    private var _id: Int
    private var _birthRate : Double
    private var _timeSinceLastEmit : TimeInterval
   
    var birthRate : TimeInterval? {
        set {
            _birthRate = (newValue)!
        }
        get {
            return _birthRate
        }
    }
    
    var timeSinceLastEmit : TimeInterval? {
        set {
            _timeSinceLastEmit = (newValue)!
        }
        get {
            return _timeSinceLastEmit
        }
    }
    
    var id: Int? {
        get {
            return _id
        }
    }
    
    init(id: Int, birthRate: Double) {

        _id = id
        _timeSinceLastEmit = 0.0
        _birthRate = birthRate
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        _timeSinceLastEmit = _timeSinceLastEmit.advanced(by: seconds)
        if !(timeSinceLastEmit?.isLess(than: Double(1.0/_birthRate)))! {
            NotificationCenter.default.post(name: .emit, object: nil, userInfo: ["id" : _id])
            timeSinceLastEmit = 0
        }
    }
}
