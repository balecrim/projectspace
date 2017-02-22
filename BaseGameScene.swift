//
//  BaseGameScene.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/21/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class BaseGameScene: IsometricGameScene{
    
    var cam: SKCameraNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        cam = SKCameraNode.init()
        camera = cam
        
        #if os(tvOS)
            camera?.xScale = 0.75
            camera?.yScale = 0.75
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


}
