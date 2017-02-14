//
// Created by Bernardo Alecrim on 2/6/17.
// Copyright (c) 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class IsometricGameScene: SKScene{

    let isometricView: SKSpriteNode
    let tileSize = (width:32, height:32)

    fileprivate var tileStorage: [[[SKTileableNode]]] = []
    
    var tileSet: [[[SKTileableNode]]]{
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
    
    func placeIsometricTile(tile: SKTileableNode, atPosition position: CGPoint, onLayer: Int) {

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
        tile.gridPosition = (x: Int(position.x), y: Int(position.y), z: onLayer)

        //check if there's an old tile at that position and remove it...
        if let oldTile = tileSet[safe: onLayer]?[safe: Int(position.y)]?[safe: Int(position.x)]{
            oldTile.removeFromParent()
        }
        
        isometricView.addChild(tile)
    }

    /// Sets the correct zPosition for all tiles on a tileSet, 
    /// leaving the scene ready for occlusion support.
    ///
    /// - Parameter tileSet: the tileSet to perform height adjustment on.
    /// - Returns: A copy of the tileSet with adjusted heights.
    
    func setHeights(on tileSet: [[[SKTileableNode]]]) -> [[[SKTileableNode]]]{
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
    
    func buildIsometricScene(for tileSet: [[[SKTileableNode]]]) {
        
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
    
    func getTileForPosition(at pos: (x: Int, y: Int, z: Int)) -> SKTileableNode?{
        return tileSet[safe: pos.z]?[safe: pos.y]?[safe: pos.x]
    }
    
    //EXPERIMENTAL VERSION, use with EXTREME caution.
    func moveTile(tile: SKTileableNode, on direction: MovementDirection){
        
        if let destination = getTileForPosition(at: tile.neighbourPosition(for: direction)) as? SKTileNode{
            if let destFloor = getTileForPosition(at: destination.underneathPosition()) as? SKTileNode{
                if (destination.isAccessible && destFloor.isAccessible){
                    
                    //storing positions
                    let originalPosition = tile.gridPosition
                    let destinationPosition = destination.gridPosition
                    
                    //moving tile in the scene
                    tile.position = destination.position
                    
                    //removing old tile from the scene
                    destination.removeFromParent()
                    
                    //reorganizing the matrix
                    tileSet[destinationPosition.z][destinationPosition.y][destinationPosition.y] = tile
                    tileSet[originalPosition.z][originalPosition.y][originalPosition.y] = .air
                    
                    //adding air back into the scene
                    isometricView.addChild(tileSet[originalPosition.z][originalPosition.y][originalPosition.y])
                    
                }
        
            }
        }
    }
}


