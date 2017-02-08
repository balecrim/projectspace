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
        
        tiles = [
            [8, 1, 1, 1, 1, 2],
            [7 ,0, 0, 0, 0, 0],
            [7 ,0, 0, 0, 0, 0],
            [7 ,0, 0, 0, 0, 0],
            [7 ,0, 0, 0, 0, 0],
            [6, 0, 0, 0, 0, 0]
        ]
        
        super.didMove(to: view)
        
    }


}

