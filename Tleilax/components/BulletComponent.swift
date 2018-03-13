//
//  BulletComponent.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 09.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class BulletComponent : GKComponent {
    
    private var _type: BulletType
    private var _initialPosition: CGPoint
    
    var bulletType : BulletType {
        set {
            _type = newValue
        }
        get {
            return _type
        }
    }
    
    var initialPosition : CGPoint {
        set {
            _initialPosition = newValue
        }
        get {
            return _initialPosition
        }
    }
    
    init(bulletType: BulletType, initialPosition: CGPoint) {
        _type = bulletType
        _initialPosition = initialPosition
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
