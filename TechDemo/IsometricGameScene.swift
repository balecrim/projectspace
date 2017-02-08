//
// Created by Bernardo Alecrim on 2/6/17.
// Copyright (c) 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class IsometricGameScene: SKScene{

    var is2DViewHidden: Bool = false
    var isIsometricViewHidden: Bool = false

    func convertToIsometricPoint(p:CGPoint) -> CGPoint {

        //invert y pre conversion
        var point = p * CGPoint(x:1, y:-1)

        //convert using algorithm
        point = CGPoint(x:(point.x - point.y), y: ((point.x + point.y) / 2))

        //invert y post conversion
        point = point * CGPoint(x:1, y:-1)

        return point

    }

    func convertTo2dPoint(p:CGPoint) -> CGPoint {

        //invert y pre conversion
        var point = p * CGPoint(x:1, y:-1)

        //convert using algorithm
        point = CGPoint(x:((2 * point.y + point.x) / 2), y: ((2 * point.y - point.x) / 2))

        //invert y post conversion
        point = point * CGPoint(x:1, y:-1)

        return point

    }


}
