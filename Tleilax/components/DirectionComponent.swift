//
//  DirectionComponent.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 05.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class DirectionComponent: GKComponent {

    private var _direction : CGPoint
    
    var direction : CGPoint? {
        set
        {
            _direction = (newValue)!
        }
        get
        {
            return _direction
        }
    }
    
    init(direction: CGPoint) {
        self._direction = direction
        super.init()
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
