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

    static var baseSize: CGSize = CGSize(width: 64, height: 64)
    
    enum TileState{
        case inactive
        case interacting
        case objectiveFulfilled
    }
    
    enum TileHeight{
        case halfHeight
        case fullHeight
        case doubleHeight
    }


    var isAccessible: Bool = true
    var isInteractive: Bool = false
    var currentState: TileState = .inactive

    var depth: Int = 0
    let height: TileHeight

    
    required init?(coder aDecoder: NSCoder) {
        height = .fullHeight
        super.init(coder: aDecoder)
    }
    
    init(spriteName: String = "iso_ground",
         tileDepth: Int = 0,
         accessible: Bool = true,
         interactive: Bool = false,
         tileHeight: TileHeight = .fullHeight){

        height = tileHeight
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
         interactive: Bool = false,
         tileHeight: TileHeight = .fullHeight){
        
        depth = tileDepth
        isAccessible = accessible
        isInteractive = interactive
        height = tileHeight

        
        super.init(texture: spriteTexture,
                   color: UIColor.red,
                   size: spriteTexture.size())
        
    }
    
    init(color: UIColor = UIColor.red,
         tileDepth: Int = 0,
         accessible: Bool = true,
         interactive: Bool = false,
         tileHeight: TileHeight = .fullHeight){
        
        depth = tileDepth
        isAccessible = accessible
        isInteractive = interactive
        height = tileHeight

        
        super.init(texture: nil,
                   color: color,
                   size: SKTileNode.baseSize)
        
    }
    
}

extension SKTileNode{
    
    static var ground: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isocube",
                                   tileDepth: 0,
                                   accessible: true,
                                   interactive: false,
                                   tileHeight: .fullHeight)
        }
    }
    
    static var slab: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isoslab",
                                   tileDepth: 0,
                                   accessible: true,
                                   interactive: false,
                                   tileHeight: .halfHeight)
        }
    }
    
    static var wall: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isowall",
                                   tileDepth: 0,
                                   accessible: true,
                                   interactive: false,
                                   tileHeight: .doubleHeight)
        }
    }


    
    static var redTile: SKTileNode{
        get{
            return SKTileNode.init(color: UIColor.red,
                                   tileDepth: 0,
                                   accessible: true,
                                   interactive: false,
                                   tileHeight: .fullHeight)
        }
    }

}

