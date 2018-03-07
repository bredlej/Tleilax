//
//  TouchReleased.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 06.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class TouchReleased: GKState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is TouchPressed.Type
    }
}
