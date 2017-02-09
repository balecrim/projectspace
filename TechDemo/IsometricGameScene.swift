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
        
            [[SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
             [SKTileNode.ground, SKTileNode.ground, SKTileNode.ground],
             [SKTileNode.ground, SKTileNode.ground, SKTileNode.ground]]
    
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

        let deviceScale = self.size.width/667

            viewIso.xScale = deviceScale
            viewIso.yScale = deviceScale
            addChild(viewIso)
            
            buildIsometricScene()
            
            viewIso.position = CGPoint(x: -self.size.width*0.05,
                                       y: self.size.height*0.15)


        
    }

    // MARK: Isometric tile placement

    func placeIsometricTile(tile: SKTileNode, atPosition position: CGPoint) {

                let point = CGPoint(x: (position.x * CGFloat(tileSize.width)),
                            y: -(position.y * CGFloat(tileSize.height))).isometric

        tile.position = point
        tile.anchorPoint = CGPoint(x:0, y:0)

        viewIso.addChild(tile)
    }


    func buildIsometricScene() {
        
        for (layerNumber, layer) in layeredTiles.enumerated(){
            for (rowNumber, row) in layer.enumerated(){
                for (columnNumber, tile) in row.enumerated(){
                    
                    placeIsometricTile(tile: tile,
                                       atPosition: CGPoint(x: columnNumber, y: rowNumber))
                    
                    
                }
            }
        }
        
    }


}
