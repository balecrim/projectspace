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

    override func didMove(to view: SKView) {
        
        tileSet = [[[SKTileNode.ground, SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
                    [SKTileNode.ground, SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
                    [SKTileNode.ground, SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
                    [SKTileNode.ground, SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
                    [SKTileNode.ground, SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
                    [SKTileNode.ground, SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
                    [SKTileNode.ground, SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
                    [SKTileNode.ground, SKTileNode.ground, SKTileNode.ground, SKTileNode.ground]],

                   [[SKTileNode.wall, SKTileNode.wall, SKTileNode.wall, SKTileNode.wall],
                        [SKTileNode.wall],
                        [SKTileNode.wall],
                        [SKTileNode.wall],
                        [SKTileNode.wall],
                        [SKTileNode.wall],
                        [SKTileNode.wall],
                        [SKTileNode.wall]]]

        
        super.didMove(to: view)
        
    }


}

