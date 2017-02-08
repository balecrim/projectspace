//
// Created by Bernardo Alecrim on 2/8/17.
// Copyright (c) 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

//
//class Tile{
//
//    enum TileState{
//        case inactive
//        case interacting
//        case objectiveFulfilled
//    }
//
//    let isAccessible: Bool = true
//    let isInteractive: Bool = true
//    let currentState: TileState = .inactive
//    let spriteName: String = ""
//
//    init(spriteName: String){
//    }
//
//}


enum Tile: Int {

    case ground //0
    case wall_n //1
    case wall_ne //2
    case wall_e //3
    case wall_se //4
    case wall_s //5
    case wall_sw //6
    case wall_w //7
    case wall_nw //8

    var description: String {
        switch self {
        case .ground:
            return "Ground"
        case .wall_n:
            return "Wall North"
        case .wall_ne:
            return "Wall North East"
        case .wall_e:
            return "Wall East"
        case .wall_se:
            return "Wall South East"
        case .wall_s:
            return "Wall South"
        case .wall_sw:
            return "Wall South West"
        case .wall_w:
            return "Wall West"
        case .wall_nw:
            return "Wall North West"
        }
    }

    var image: String {
        switch self {
        case .ground:
            return "ground"
        case .wall_n:
            return "wall_n"
        case .wall_ne:
            return "wall_ne"
        case .wall_e:
            return "wall_e"
        case .wall_se:
            return "wall_se"
        case .wall_s:
            return "wall_s"
        case .wall_sw:
            return "wall_sw"
        case .wall_w:
            return "wall_w"
        case .wall_nw:
            return "wall_nw"
        }
    }
}