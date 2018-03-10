//
//  Bullet.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 08.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

import GameplayKit

class Bullet : GKEntity {
   
    override init() {
        super.init()
        addComponent(SpriteComponent(texture: SKTextureAtlas(named: "blueBlast.atlas").textureNamed("blueBlast3")))
        addComponent(BulletComponent())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
