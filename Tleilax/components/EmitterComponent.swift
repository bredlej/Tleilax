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
    private var _readyToEmit: Bool
   
    var id: Int? {
        get {
            return _id
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
    
    var birthRate : TimeInterval? {
        set {
            _birthRate = (newValue)!
        }
        get {
            return _birthRate
        }
    }
    
    var readyToEmit: Bool {
        set {
            _readyToEmit = newValue
        }
        get {
            return _readyToEmit
        }
    }
    
    init(id: Int, birthRate: Double) {
        _id = id
        _timeSinceLastEmit = 0.0
        _birthRate = birthRate
        _readyToEmit = false
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func emit() {
        _readyToEmit = false
    }
}
