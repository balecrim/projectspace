//
//  HallScene.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/21/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class HallScene: BaseGameScene {
    
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
        
        
        tileSet = [[[.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.ground, button, .ground, .ground]]]
        
        
        super.didMove(to: view)
        self.name = "hallScene"

        
        scene?.addChild(cam)
        
        placeIsometricTile(tile: character!, atPosition: CGPoint(x: 1, y:1), onLayer: 1)
        character?.zPosition = 100
        
    }
    
    
    
}
