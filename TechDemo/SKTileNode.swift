//
//  SKTileNode.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/9/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class SKTileNode: SKSpriteNode{

    static var spriteSize: CGSize = CGSize(width: 32, height: 32)
    
    enum TileState{
        case inactive
        case interacting
        case objectiveFulfilled
    }

    var isAccessible: Bool = true
    var isInteractive: Bool = false
    var currentState: TileState = .inactive

    var depth: Int = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(spriteName: String = "iso_ground",
         tileDepth: Int = 0,
         accessible: Bool = true,
         interactive: Bool = false){

        depth = tileDepth
        isAccessible = accessible
        isInteractive = interactive

        super.init(texture: SKTexture.init(imageNamed: spriteName),
                   color: UIColor.red,
                   size: SKTexture.init(imageNamed: spriteName).size())
        
    }
    
    init(spriteTexture: SKTexture = SKTexture.init(imageNamed: "iso_ground"),
         tileDepth: Int = 0,
         accessible: Bool = true,
         interactive: Bool = false){
        
        depth = tileDepth
        isAccessible = accessible
        isInteractive = interactive
        
        super.init(texture: spriteTexture,
                   color: UIColor.red,
                   size: spriteTexture.size())
        
    }
    
}

extension SKTileNode{
    
    static var ground: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "iso_ground",
                                   tileDepth: 0,
                                   accessible: true,
                                   interactive: false)
        }
    }

}

