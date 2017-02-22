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

    var isAccessible: Bool = true
    var information: [String] = []
    var soundID: String = ""

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(spriteName: String = "iso_ground",
         tileDepth: Int = 0,
         accessible: Bool = true,
         tileHeight: TileHeight = .fullHeight,
         tileInformation: [String] = [],
         sound: String = "trash"){

        isAccessible = accessible
        information = tileInformation
        soundID = sound


        super.init(texture: SKTexture.init(imageNamed: spriteName),
                   color: UIColor.clear,
                   size: SKTileableNode.getSizeFor(height: tileHeight),
                   height: tileHeight)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    init(spriteTexture: SKTexture? = SKTexture.init(imageNamed: "iso_ground"),
         tileDepth: Int = 0,
         accessible: Bool = true,
         tileHeight: TileHeight = .fullHeight,
         tileInformation: [String] = [],
         sound: String = "trash"){

        isAccessible = accessible
        information = tileInformation
        soundID = sound



        super.init(texture: spriteTexture,
                   color: UIColor.clear,
                   size: SKTileableNode.getSizeFor(height: tileHeight),
                   height: tileHeight)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

    }
    
    
    
    init(color: UIColor = UIColor.clear,
         tileDepth: Int = 0,
         accessible: Bool = true,
         tileHeight: TileHeight = .fullHeight,
         tileInformation: [String] = [],
         sound: String = "trash"){

        isAccessible = accessible
        information = tileInformation
        soundID = sound

        super.init(texture: nil,
                   color: color,
                   size: SKTileableNode.getSizeFor(height: tileHeight),
                   height: tileHeight)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

    }
    
    
}
