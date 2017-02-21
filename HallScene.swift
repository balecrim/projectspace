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
        
        let exitDoor = SKInteractiveNode.init(textures: [.inactive: SKTexture.init(imageNamed: "exitDoor")],
                                          tileHeight: .doubleHeight,
                                          interactionType: .door)
        
        let button = SKInteractiveNode.init(textures: buttonTextures,
                                            tileDepth: 0,
                                            tileHeight: .fullHeight,
                                            interactionType: .animatable,
                                            activateAction: {
                                                exitDoor.activate()
        },
                                            deactivateAction: {
                                                exitDoor.deactivate()
        })
        
        
        tileSet = [[[.hardair, .hardair, .hardair],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair,  button, .ground, .ground],
                    [.hardair, .ground, .ground, .ground],
                    [.hardair, .ground, .ground, .ground]],
                   
                   [[.hardair, .showcase, .showcase, .showcase],
                    [.wall_hall, .air, .air, .air],
                    [.wall_alarm, .air, .air, .air],
                    [.wall_hall, .air, .air, .air],
                    [.dorm3, .papers, .air, .air],
                    [.wall_hall, .air, .air, .air],
                    [.wall_alarm, .trash, .air, .air],
                    [.wall_hall, .air, .air, .air],
                    [.dorm2, .air, .air, .papers],
                    [.wall_hall, .air, .air, .air],
                    [.log_hall, .plant, .air, .air],
                    [.wall_hall, .air, .air, .air],
                    [.dorm1, .air, .air, .air],
                    [.wall_hall, .air, .air, .air],
                    [.wall_alarm, .air, .air, .air],
                    [.wall_hall, .air, .air, .air],
                    [exitDoor, .air, .air, .plant]]
        ]
        
        
        super.didMove(to: view)
        self.name = "hallScene"

        
        scene?.addChild(cam)
        placeIsometricTile(tile: character!, atPosition: CGPoint(x: 1, y:1), onLayer: 1)
        character?.zPosition = 100        
    }
    
    
    
}
