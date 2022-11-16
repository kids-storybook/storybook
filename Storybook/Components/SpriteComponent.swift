//
//  SpriteComponent.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
    //
    //  // A node that gives an entity a visual sprite
    //  let node: EntityNode
    let node: SKSpriteNode
    let sound: SKAction
    
    init(entity: GKEntity, texture: SKTexture, size: CGSize, sound: SKAction) {
        node = SKSpriteNode(texture: texture,color: SKColor.white, size: size)
        self.sound = sound
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

