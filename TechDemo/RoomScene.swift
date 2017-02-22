//
//  GameScene.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/6/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import SpriteKit
import GameplayKit

import SpriteKit

class RoomScene: BaseGameScene {
    
    override func didMove(to view: SKView) {
        
        character = SKCharacterNode.defaultChar
        character?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
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
        
        let transition = SKTransition.fade(with: UIColor.black, duration: 1)
        let newScene = HallScene.init(size: self.size)
        
        
        
        let transitionButton = SKInteractiveNode.init(textures: transitionTextures,
                                                      tileDepth: 0,
                                                      tileHeight: .fullHeight,
                                                      interactionType: .animatable,
                                                      activateAction: {
                                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                                                                self.view?.presentScene(newScene,
                                                                                        transition: transition)
                                                        })
                                                      })
        
        
        
        tileSet = [[[.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [transitionButton, button, .ground, .ground]],

                   [[.postItWall, .bedL, .bedR, .log],
                    [.shelf, .air, .air, .air],
                    [.closet, .air, .air, .air],
                    [ door, .air, .air, .trash],
                    [.hardair, .hardair, .hardair, .hardair]]]

        
        super.didMove(to: view)
        self.name = "roomScene"
        
        scene?.addChild(cam)
        
        placeIsometricTile(tile: character!, atPosition: CGPoint(x: 1, y:1), onLayer: 1)
        character?.zPosition = 100
        door.zPosition = 101
        
        if let character = self.character{
            
            balloonNode = SKBalloonNode.init(text: "", color: nil)
            
            if let balloon = self.balloonNode{
                
                let balPosition = CGPoint(x: character.position.x + (balloon.size.width * 0.8),
                                          y: character.position.y + (balloon.size.height * 1.25))

                balloon.position = balPosition
                self.addChild(balloon)
                balloon.zPosition = 102
                balloon.show(for: ["Hey, this works again!",
                                   "Now, we should reimplement the movement + sync with character."])
            }

        }
        
        
        
        
    }



}

