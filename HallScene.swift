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
        
        characterNode = SKCharacterNode.defaultChar
        
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
                    [.dorm3, .air, .air, .air],
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
        placeIsometricTile(tile: characterNode!, atPosition: CGPoint(x: 1, y:3), onLayer: 1)
        characterNode?.currentDirection = .right
        characterNode!.zPosition = 100
        
        balloonNode = SKBalloonNode.init(text: "", color: nil)
        

        if let character = self.characterNode{
            if let balloon = self.balloonNode{
                
                let balPosition = CGPoint(x: character.position.x + (balloon.size.width * 0.8),
                                          y: character.position.y + (balloon.size.height * 1.25))
                
                balloon.position = balPosition
                self.addChild(balloon)
                balloon.zPosition = 102
                balloon.show(for: ["I need to get to the log viewer down the hall",
                                   "That will give me a better chance to figure out what's going on."])
            }

        }
        
    }
    
    
    
}
