//
//  LocalPositionComponent.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 06.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class LocalPositionComponent: GKComponent {

    private var _position : CGPoint
    
    var position: CGPoint? {
        set {
            _position = (newValue)!
        }
        get {
            return _position
        }
    }
    
    init(position: CGPoint) {
        _position = position
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
