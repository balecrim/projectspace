//
//  EnvironmentTiles.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/15/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

extension SKTileableNode{
    
    static var ground: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isocube",
                                   tileDepth: 0,
                                   accessible: true,
                                   tileHeight: .fullHeight)
        }
    }
        
    static var wall: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isowall",
                                   tileDepth: 0,
                                   accessible: false,
                                   tileHeight: .doubleHeight)
        }
    }
    
    static var postItWall: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isopostit",
                                   tileDepth: 0,
                                   accessible: false,
                                   tileHeight: .doubleHeight)
        }
    }

    
    static var air: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "transparent",
                                   tileDepth: 0,
                                   accessible: true,
                                   tileHeight: .fullHeight)
        }
    }
    
    static var closet: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isocloset",
                                   tileDepth: 0,
                                   accessible: false,
                                   tileHeight: .doubleHeight)
            
        }
    }
    
    static var bedL: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "bedL",
                                   tileDepth: 0,
                                   accessible: false,
                                   tileHeight: .doubleHeight)
            
        }
    }
    
    static var bedR: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "bedR",
                                   tileDepth: 0,
                                   accessible: false,
                                   tileHeight: .doubleHeight)
            
        }
    }
    
    static var log: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isolog",
                                   tileDepth: 0,
                                   accessible: false,
                                   tileHeight: .doubleHeight)
            
        }
    }
    
    static var shelf: SKTileNode{
        get{
            return SKTileNode.init(spriteName: "isoshelf",
                                   tileDepth: 0,
                                   accessible: false,
                                   tileHeight: .doubleHeight)
            
        }
    }


    
    static var trash: SKInteractiveNode{
        get{
            let texture = SKTexture.init(imageNamed: "trashCan")
            return SKInteractiveNode.init(textures: [.inactive: texture],
                                          tileDepth: 0,
                                          tileHeight: .fullHeight)
            
        }
    }
    
    
    
}
