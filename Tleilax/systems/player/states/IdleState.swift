//
//  IdleState.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class IdleState : GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is RotationState.Type
    }
}
