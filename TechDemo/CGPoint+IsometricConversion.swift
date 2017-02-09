//
// Created by Bernardo Alecrim on 2/8/17.
// Copyright (c) 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGPoint{

    var isometric: CGPoint{
        get{
            //invert y pre conversion
            var point = self
            point = point * CGPoint(x:1, y:-1)

            //convert using algorithm
            point = CGPoint(x:(point.x - point.y), y: ((point.x + point.y) / 2))

            //invert y post conversion
            point = point * CGPoint(x:1, y:-1)

            return point

        }
    }
    
    var grid2d: CGPoint{
        get{
            //invert y pre conversion
            var point = self
            point = point * CGPoint(x:1, y:-1)

            //convert using algorithm
            point = CGPoint(x:((2 * point.y + point.x) / 2), y: ((2 * point.y - point.x) / 2))
            
            //invert y post conversion
            point = point * CGPoint(x:1, y:-1)
            
            return point
        }
    }
}
