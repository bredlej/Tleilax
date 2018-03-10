//
//  BirthRateComponent.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 07.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class BirthRateComponent : GKComponent {
    
    private var _birthRate: Double
    
    var birthRate : Double? {
        set {
            _birthRate = (newValue)!
        }
        get {
            return _birthRate
        }
    }
    
    init(birthRate: Double) {
        _birthRate = birthRate
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
