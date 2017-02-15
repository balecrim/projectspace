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
    
    override func didMove(to view: SKView) {
        
        character = SKCharacterNode.defaultChar
        
        tileSet = [[[.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground]],

                   [[.closet, .bedL, .bedR, .closet],
                    [.closet, .air, .air, .air],
                    [.closet, .air, .air, .air],
                    [.closet, .air, .air, .air]]]

        
        super.didMove(to: view)
        placeIsometricTile(tile: character!, atPosition: CGPoint(x: 1, y:1), onLayer: 1)
        character?.zPosition = 100
    }


}

