//
//  VelocityComponent.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 05.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class VelocityComponent: GKComponent {

    private var _velocity: CGFloat
    var velocity: CGFloat? {
        set {
            _velocity = (newValue)!
        }
        get {
            return _velocity
        }
    }
    
    init(velocity: CGFloat) {
        _velocity = velocity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
