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

class GameScene: IsometricGameScene {
    
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
        let trash = SKTileableNode.trash
        
        tileSet = [[[.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground]],

                   [[.postItWall, .bedL, .bedR, .closet],
                    [.closet, .air, .air, .air],
                    [.wall, .air, .air, .air],
                    [.wall, .air, .air, trash]]]

        
        super.didMove(to: view)
        
        scene?.addChild(cam)
        
        placeIsometricTile(tile: character!, atPosition: CGPoint(x: 1, y:1), onLayer: 1)
        character?.zPosition = 100
        
//        trash.activate()
    }



}

