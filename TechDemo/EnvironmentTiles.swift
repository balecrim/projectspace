//
//  EnvironmentTiles.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/15/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation

extension SKTileableNode{
    
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
                                   accessible: false,
                                   interactive: false,
                                   tileHeight: .doubleHeight)
        }
    }
    
    static var air: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "transparent",
                                   tileDepth: 0,
                                   accessible: true,
                                   interactive: false,
                                   tileHeight: .fullHeight)
        }
    }
    
    static var closet: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isocloset",
                                   tileDepth: 0,
                                   accessible: false,
                                   interactive: false,
                                   tileHeight: .doubleHeight)
            
        }
    }
    
    static var bedL: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "bedL",
                                   tileDepth: 0,
                                   accessible: false,
                                   interactive: false,
                                   tileHeight: .doubleHeight)
            
        }
    }
    
    static var bedR: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "bedR",
                                   tileDepth: 0,
                                   accessible: false,
                                   interactive: false,
                                   tileHeight: .doubleHeight)
            
        }
    }
    
    static var button: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "button",
                                   tileDepth: 0,
                                   accessible: true,
                                   interactive: true,
                                   tileHeight: .doubleHeight)
            
        }
    }
    
    
    
}
