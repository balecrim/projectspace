//
//  HallScene.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/21/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class HallScene: IsometricGameScene {
    
    var character: SKCharacterNode?
    var cam: SKCameraNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        cam = SKCameraNode.init()
        camera = cam
        
        #if os(tvOS)
            camera?.xScale = 0.5
            camera?.yScale = 0.5
        #elseif os(iOS)
            camera?.xScale = 1
            camera?.yScale = 1
        #endif
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cam = SKCameraNode.init()
        camera = cam
        camera?.xScale = 0.5
        camera?.yScale = 0.5
        
    }
    
    
    override func didMove(to view: SKView) {
        
        character = SKCharacterNode.defaultChar
        
        
        let buttonTextures: [SKInteractiveNode.TileState: SKTexture] =
            [.inactive: SKTexture.init(imageNamed: "button"),
             .interacting: SKTexture.init(imageNamed: "buttonActive")]
        
        let door = SKInteractiveNode.init(textures: [.inactive: SKTexture.init(imageNamed: "door")],
                                          tileHeight: .doubleHeight,
                                          interactionType: .door)
        
        let button = SKInteractiveNode.init(textures: buttonTextures,
                                            tileDepth: 0,
                                            tileHeight: .fullHeight,
                                            interactionType: .animatable,
                                            activateAction: {
                                                door.activate()
        },
                                            deactivateAction: {
                                                door.deactivate()
        })
        
        let transitionTextures: [SKInteractiveNode.TileState : SKTexture] =
            [.inactive: SKTexture.init(imageNamed: "isocube"),
             .interacting: SKTexture.init(imageNamed: "isocube")]
        
        
        
        tileSet = [[[.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.ground, button, .ground, .ground]],
                   
                   [[.postItWall, .bedL, .bedR, .log],
                    [.shelf, .air, .air, .air],
                    [.closet, .air, .air, .air],
                    [ door, .air, .air, .trash],
                    [.hardair, .hardair, .hardair, .hardair]]]
        
        
        super.didMove(to: view)
        
        scene?.addChild(cam)
        
        placeIsometricTile(tile: character!, atPosition: CGPoint(x: 2, y:1), onLayer: 1)
        character?.zPosition = 100
        
    }
    
    
    
}
