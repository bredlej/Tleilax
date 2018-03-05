//
//  NodeComponent.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 05.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import SpriteKit
import GameplayKit

class NodeComponent: GKComponent {

    let node: SKNode
    
    override init() {
        node = SKNode()
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
