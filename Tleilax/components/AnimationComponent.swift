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
    
    var frames : [GKState: [SKTexture]] = [:]
    
    init(stateToTextureMap : [GKState: SKTextureAtlas]) {
        for state in stateToTextureMap.keys {
            var textures : [SKTexture] = []
            for textureName in (stateToTextureMap[state]?.textureNames)! {
                textures.append((stateToTextureMap[state]?.textureNamed(textureName))!)
            }
            frames[state] = textures
        }
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
