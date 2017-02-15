//
// Created by Bernardo Alecrim on 2/14/17.
// Copyright (c) 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

enum MovementDirection{
    case up, down, left, right
}


class SKCharacterNode: SKTileableNode {
    fileprivate var directionStorage: MovementDirection = .up
    
    var currentDirection: MovementDirection {
        get{
            return directionStorage
        }
        set {
            if let newTexture = textures[newValue]{
                texture = newTexture
            }
        }
    }
    
    var textures: [MovementDirection: SKTexture] = [:]
    
    func prepareForMovement(to direction: MovementDirection){
        currentDirection = direction
    }

    static var defaultChar: SKCharacterNode{
    get{
        let texture = SKTexture.init(imageNamed: "droid")
        return SKCharacterNode.init(texture: texture,
                                    color: UIColor.red,
                                    size: texture.size(),
                                    height: .fullHeight)
        }
    }
    
}
