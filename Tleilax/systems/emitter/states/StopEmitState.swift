//
//  StopEmitState.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 08.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class StopEmitState : GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is EmitState.Type
    }
}
