//
// Created by Bernardo Alecrim on 2/6/17.
// Copyright (c) 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class IsometricGameScene: SKScene{

    let isometricView: SKSpriteNode
    
    let tileSize = (width:128, height:128)

    fileprivate var tileStorage: [[[SKTileableNode]]] = []
    
    var tileSet: [[[SKTileableNode]]]{
        get{ return tileStorage }
        set{
            let adjustedTileSet = setHeights(on: newValue)
            tileStorage = adjustedTileSet
        }
        
    }
    
    var activeTiles: [SKInteractiveNode] = []
    
    var nextCameraPosition: CGPoint?

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
    
        isometricView.position = CGPoint(x: 0.5, y: 0.5)
    }

    // MARK: Isometric character placement

    /// Calculates position for character based on its position and layer, then adds it to the
    /// isometricView node.
    ///
    /// - Parameters:
    ///   - character: the character which should be added.
    ///   - position: the position which it should be placed at.
    ///   - onLayer: the layer which it should be placed on.
    
    func placeIsometricTile(tile: SKTileableNode, atPosition position: CGPoint, onLayer: Int) {
        
        //calculating placement point for the character, then beating it into our isometric grid.
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
        point = point - CGPoint(x: 0, y: CGFloat((-onLayer * (tileSize.height / 2))))

        //setting up character
        tile.position = point
        tile.anchorPoint = CGPoint(x:0, y:0)
        tile.gridPosition = (x: Int(position.x), y: Int(position.y), z: onLayer)

        //check if there's an old character at that position and remove it...
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
            for (_, row) in layer.enumerated(){
                for (columnNumber, tile) in row.enumerated(){
                    
                    tile.zPosition = CGFloat(columnNumber + layerNumber)
                    
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
    
    func getNearbyTiles(for tile: SKTileableNode) -> [SKTileableNode]{
        var tileArray: [SKTileableNode?] = []
        
        tileArray.append(getTileForPosition(at: tile.neighbourPosition(for: .up)))
        tileArray.append(getTileForPosition(at: tile.neighbourPosition(for: .down)))
        tileArray.append(getTileForPosition(at: tile.neighbourPosition(for: .left)))
        tileArray.append(getTileForPosition(at: tile.neighbourPosition(for: .right)))

        var returnArray: [SKTileableNode] = []
        
        for tile in tileArray{
            if let unwrappedTile = tile{
                returnArray.append(unwrappedTile)
            }
        }
        
        return returnArray
    }
    
    func move(character: SKCharacterNode, on direction: MovementDirection){
        DispatchQueue.global().async {
            
            ///Phase 1: change direction for character...
            
            character.prepareForMovement(to: direction)
            
            ///Phase 2: check if there's an active tile in front of the character...
            
            DispatchQueue.main.async {
                //handling character hinting...
                let nearbyTile = self.getTileForPosition(at: character.neighbourPosition(for: direction))
                if let nearbyInteractive = nearbyTile as? SKInteractiveNode{
                    nearbyInteractive.hint()
                }

            }
            
            ///Phase 3: if there's an accessible tile in front of it, actually move character...

            if let destination = self.getTileForPosition(at: character.neighbourPosition(for: direction)) as? SKTileNode{
                    //print(destination.isAccessible)
                    if (destination.isAccessible){
                        
                        //storing positions
                        let originalPosition = character.gridPosition
                        let destinationPosition = destination.gridPosition
                        
                        print("original:", originalPosition, " destination:", destinationPosition, "direction:", direction)
                        character.gridPosition = destinationPosition

                        //moving character in the scene
                        DispatchQueue.main.async {
                            
                            let movementAction = SKAction.move(to: destination.position, duration: 0.25)
                            character.run(movementAction)
                            
                            self.nextCameraPosition = destination.position
                            
                    }
                }
            }
        
        }
    }
    
    
    ///Galera, isso é um mock, tá?
    
//    func buttonCheck(){
//        
//        for (layerNumber, layer) in tileSet.enumerated(){
//            for (rowNumber, row) in layer.enumerated(){
//                for (columnNumber, tile) in row.enumerated(){
//                    
//                    if let button = getTileForPosition(at: tile.underneathPosition()){
//                        if (button is SKInteractiveNode && tile is SKInteractiveNode){
//                            DispatchQueue.main.async {
//                                button.onActivate()
//                            }
//                        }
//                    }
//                    
//                }
//            }
//        }
//
//        
//        
//    }
    
    func characterSelect(near tile: SKCharacterNode){
        //in case there's something that is already selected...
        if activeTiles.count > 0{
            for tile in activeTiles{
                tile.deactivate()
                activeTiles.remove(at: self.activeTiles.index(of: tile)!)
                
            }
        } else {
            //otherwise, select something.
            let nearbyTile = self.getTileForPosition(at: tile.neighbourPosition(for: tile.currentDirection))
            if let nearbyInteractive = nearbyTile as? SKInteractiveNode{
                nearbyInteractive.activate()
                self.activeTiles.append(nearbyInteractive)
            }
            
        }
    }
        
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if let nextPos = nextCameraPosition{
            let movementAction = SKAction.move(to: nextPos, duration: 0.5)
            camera?.run(movementAction)
            
        }
        
    }

}


