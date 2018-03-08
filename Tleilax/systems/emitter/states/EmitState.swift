//
//  EmitState.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 08.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class EmitState : GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is StopEmitState.Type
    }
}
