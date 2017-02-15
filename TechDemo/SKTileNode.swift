//
//  SKTileNode.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/9/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class SKTileNode: SKTileableNode{

    static var baseSize: CGSize = CGSize(width: 128, height: 128)
    
    enum TileState {
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
         interactive: Bool = false,
         tileHeight: TileHeight = .fullHeight){

        depth = tileDepth
        isAccessible = accessible
        isInteractive = interactive

        super.init(texture: SKTexture.init(imageNamed: spriteName),
                   color: UIColor.red,
                   size: SKTileNode.getSizeFor(height: tileHeight),
                   height: tileHeight)
        
    }
    
    init(spriteTexture: SKTexture = SKTexture.init(imageNamed: "iso_ground"),
         tileDepth: Int = 0,
         accessible: Bool = true,
         interactive: Bool = false,
         tileHeight: TileHeight = .fullHeight){
        
        depth = tileDepth
        isAccessible = accessible
        isInteractive = interactive
        
        super.init(texture: spriteTexture,
                   color: UIColor.red,
                   size: SKTileNode.getSizeFor(height: tileHeight),
                   height: tileHeight)
        
    }
    
    init(color: UIColor = UIColor.red,
         tileDepth: Int = 0,
         accessible: Bool = true,
         interactive: Bool = false,
         tileHeight: TileHeight = .fullHeight){
        
        depth = tileDepth
        isAccessible = accessible
        isInteractive = interactive
        
        super.init(texture: nil,
                   color: color,
                   size: SKTileNode.getSizeFor(height: tileHeight),
                   height: tileHeight)
        
    }
    
    static func getSizeFor(height: TileHeight) -> CGSize{
        
        let finalSize: CGSize
        
        switch height{
        case .halfHeight:
            finalSize = CGSize(width: SKTileNode.baseSize.width, height: SKTileNode.baseSize.height * 0.5)
        case .fullHeight:
            finalSize = SKTileNode.baseSize
        case .doubleHeight:
            finalSize = CGSize(width: SKTileNode.baseSize.width, height: SKTileNode.baseSize.height * 1.5)
        }

        return finalSize
    }
    
}
