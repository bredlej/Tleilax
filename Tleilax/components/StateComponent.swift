//
//  StateComponent.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class StateComponent: GKComponent {

    var state : GKStateMachine?
    
    init (_ states: [GKState]) {
        state = GKStateMachine(states: states)
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
