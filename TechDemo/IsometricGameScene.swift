//
// Created by Bernardo Alecrim on 2/6/17.
// Copyright (c) 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class IsometricGameScene: SKScene{

    let isometricView: SKSpriteNode
    let tileSize = (width:32, height:32)

    fileprivate var tileStorage: [[[SKTileNode]]] = []
    
    var tileSet: [[[SKTileNode]]]{
        get{ return tileStorage }
        set{
            let adjustedTileSet = setHeights(on: newValue)
            tileStorage = adjustedTileSet
        }
        
    }

    // MARK: Initializers

    override init(size: CGSize) {

        isometricView = SKSpriteNode()

        super.init(size: size)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }

    required init?(coder aDecoder: NSCoder) {

        isometricView = SKSpriteNode()

        super.init(coder: aDecoder)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }

    override func didMove(to view: SKView){

        super.didMove(to: view)

        addChild(isometricView)
        buildIsometricScene(for: tileStorage)
    
        isometricView.position = CGPoint(x: 0, y: 0)
    }

    // MARK: Isometric tile placement

    /// Calculates position for tile based on its position and layer, then adds it to the
    /// isometricView node.
    ///
    /// - Parameters:
    ///   - tile: the tile which should be added.
    ///   - position: the position which it should be placed at.
    ///   - onLayer: the layer which it should be placed on.
    
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
        tile.name = "(\(onLayer), \(position.x), \(position.y))"

        //check if there's an old tile at that position and remove it...
        if let oldTile = isometricView.childNode(withName: tile.name!){
            oldTile.removeFromParent()
        }
        
        isometricView.addChild(tile)
    }

    /// Sets the correct zPosition for all tiles on a tileSet, 
    /// leaving the scene ready for occlusion support.
    ///
    /// - Parameter tileSet: the tileSet to perform height adjustment on.
    /// - Returns: A copy of the tileSet with adjusted heights.
    
    func setHeights(on tileSet: [[[SKTileNode]]]) -> [[[SKTileNode]]]{
        for (layerNumber, layer) in tileSet.enumerated(){
            for (rowNumber, row) in layer.enumerated(){
                for (_, tile) in row.enumerated(){
                    
                    tile.zPosition = CGFloat(rowNumber + layerNumber)
                    
                }
            }
        }

        return tileSet
    }
    
    /// Renders an isometric view based on a tileSet.
    ///
    /// - Parameter tileSet: the tileSet to render.
    
    func buildIsometricScene(for tileSet: [[[SKTileNode]]]) {
        
        for (layerNumber, layer) in tileSet.enumerated(){
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
