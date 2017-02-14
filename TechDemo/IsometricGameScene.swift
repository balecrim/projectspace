//
// Created by Bernardo Alecrim on 2/6/17.
// Copyright (c) 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class IsometricGameScene: SKScene{

    let viewIso: SKSpriteNode
    let tileSize = (width:32, height:32)

    var layeredTiles: [[[SKTileNode]]] = [
        
            [[SKTileNode.ground, SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
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
             [SKTileNode.wall]]
            
        ]


    // MARK: Initializers

    override init(size: CGSize) {

        viewIso = SKSpriteNode()

        super.init(size: size)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }

    required init?(coder aDecoder: NSCoder) {

        viewIso = SKSpriteNode()

        super.init(coder: aDecoder)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }

    override func didMove(to view: SKView){

        super.didMove(to: view)

//        let deviceScale = self.size.width/667
        
//            viewIso.xScale = deviceScale
//            viewIso.yScale = deviceScale
            addChild(viewIso)
            
            buildIsometricScene()
        
            viewIso.position = CGPoint(x: 0,
                                       y: 0)

        setheights()
        printHeights()
    }

    // MARK: Isometric tile placement

    func placeIsometricTile(tile: SKTileNode, atPosition position: CGPoint, onLayer: Int) {

        //calculating placement point for the tile, then beating it into our isometric grid.
        var point: CGPoint
        
        switch tile.height{
        case .halfHeight:
             point = CGPoint(x: (position.x * CGFloat(tile.frame.width / 2)),
                             y: -((position.y * CGFloat(tile.frame.height / 2)))).isometric
            break
        case .doubleHeight:
            point = CGPoint(x: (position.x * CGFloat(tile.frame.width / 2)),
                            y: -((position.y * CGFloat(tile.frame.height / 3)))).isometric
            break
            
        case .fullHeight:
            point = CGPoint(x: (position.x * CGFloat(tile.frame.width / 2)),
                            y: -((position.y * CGFloat(tile.frame.height / 2)))).isometric
            
            
        }

        //displacing point on the Y axis based on its layer
        point = point - CGPoint(x: 0, y: CGFloat((-onLayer * (tileSize.height))))

        //setting up tile
        tile.position = point
        tile.anchorPoint = CGPoint(x:0, y:0)

        viewIso.addChild(tile)
    }

    func setheights(){
        for (layerNumber, layer) in layeredTiles.enumerated(){
            for (rowNumber, row) in layer.enumerated(){
                for (_, tile) in row.enumerated(){
                    
                    tile.zPosition = CGFloat(rowNumber + (layerNumber))
                    
                }
            }
        }

        
    }
    
    func printHeights(){
        for (_, layer) in layeredTiles.enumerated(){
            for (rowNumber, row) in layer.enumerated(){
                print("\(rowNumber): [", terminator: "")
                for (_, tile) in row.enumerated(){
                    
                    print("\(tile.zPosition), \(tile.size);", terminator: " ")
                    
                }
                print("]", terminator: "\n")
            }
        }
    }

    
    
    func buildIsometricScene() {
        
        for (layerNumber, layer) in layeredTiles.enumerated(){
            for (rowNumber, row) in layer.enumerated(){
                for (columnNumber, tile) in row.enumerated(){
                    
                    placeIsometricTile(tile: tile,
                                       atPosition: CGPoint(x: columnNumber, y: rowNumber),
                                       onLayer: layerNumber)
                    
                    
                }
            }
        }
        
    }


}
