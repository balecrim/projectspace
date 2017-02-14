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
        
        tileSet = [[[.ground, .ground, .ground, .ground, .ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground, .ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground, .ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground, .ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground, .ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground, .ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground, .ground, .ground, .ground, .ground],
                    [.ground, .ground, .ground, .ground, .ground, .ground, .ground, .ground]],

                   [[.wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall],
                    [.wall, .air, .air, .air, .air, .air, .air, .redCube],
                    [.wall, .air, .air, .air, .air, .air, .air, .redCube],
                    [.wall, .air, .air, .air, .air, .air, .air, .redCube],
                    [.wall, .air, .air, .air, .air, .air, .air, .redCube],
                    [.wall, .air, .air, .air, .air, .air, .air, .redCube],
                    [.wall, .air, .air, .air, .air, .air, .air, .redCube],
                    [.wall, .redCube, .redCube, .redCube, .redCube, .redCube, .redCube, .redCube]]]

        
        super.didMove(to: view)
        
    }


}

