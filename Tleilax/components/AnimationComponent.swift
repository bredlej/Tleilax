//
//  AnimationComponent.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 04.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit
import SpriteKit

class AnimationComponent: GKComponent {
    
    var frames : [SKTexture] = []
    var key : String = ""
    
    init(textureAtlas: SKTextureAtlas, key: String) {
        for textureName in textureAtlas.textureNames {
            frames.append(textureAtlas.textureNamed(textureName))
        }
        self.key = key
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
