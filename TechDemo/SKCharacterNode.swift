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
            directionStorage  = newValue
            
            if let newTexture = textures[newValue]{
                texture = newTexture
            }
        }
    }
    
    var textures: [MovementDirection: SKTexture] = [:]
    
    func prepareForMovement(to direction: MovementDirection){
        currentDirection = direction
        print(currentDirection)
    }
    
    init(textureDict: [MovementDirection : SKTexture], color: UIColor, height: TileHeight) {
        
        self.textures = textureDict
        
        super.init(texture: textureDict[.down],
                   color: UIColor.red,
                   size: SKTileableNode.getSizeFor(height: height),
                   height: .fullHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    static var defaultChar: SKCharacterNode{
    get{
        
        let textureDict: [MovementDirection: SKTexture] =
                                [.up:     SKTexture.init(imageNamed: "vilar_n"),
                                 .down:   SKTexture.init(imageNamed: "vilar_s"),
                                 .left:   SKTexture.init(imageNamed: "vilar_w"),
                                 .right:  SKTexture.init(imageNamed: "vilar_e")]
        
        
        
        return SKCharacterNode.init(textureDict: textureDict,
                                    color: UIColor.red,
                                    height: .doubleHeight)
        
        }
    }
    
}
