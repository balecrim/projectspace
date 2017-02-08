//
// Created by Bernardo Alecrim on 2/6/17.
// Copyright (c) 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit

class IsometricGameScene: SKScene{

    var is2DViewHidden: Bool = false
    var isIsometricViewHidden: Bool = false

    let view2D: SKSpriteNode
    let viewIso: SKSpriteNode

    let tileSize = (width:32, height:32)

    var tiles = [[1]]


    // MARK: Initializers

    override init(size: CGSize) {

        view2D = SKSpriteNode()
        viewIso = SKSpriteNode()

        super.init(size: size)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }

    required init?(coder aDecoder: NSCoder) {

        view2D = SKSpriteNode()
        viewIso = SKSpriteNode()

        super.init(coder: aDecoder)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }

    override func didMove(to view: SKView){

        super.didMove(to: view)

        let deviceScale = self.size.width/667

        if !is2DViewHidden{

//            view2D.xScale = deviceScale
//            view2D.yScale = deviceScale
            
            addChild(view2D)
            build2DScene()

            view2D.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            if !isIsometricViewHidden{
                view2D.position = CGPoint(x: -self.size.width*0.45,
                                          y: self.size.height*0.17)
            } else {
//                view2D.position = CGPoint(x: 0,
//                                          y: 0)

                view2D.position = CGPoint(x: -self.size.width*0.45,
                                          y: self.size.height*0.17)

            }

            
        }

        if !isIsometricViewHidden{

            if !isIsometricViewHidden{
                viewIso.position = CGPoint(x: self.size.width*0.12,
                                           y: self.size.height*0.12)
            } else{
                viewIso.position = CGPoint(x: 0,
                                           y: self.size.height*0.12)
            }

            viewIso.xScale = deviceScale
            viewIso.yScale = deviceScale
            addChild(viewIso)

            buildIsometricScene()

        }
        
        place2dTile(image: "ground", atPosition: CGPoint.zero)

    }

    // MARK: to-Isometric and to-2D point conversions.

    /// This function is used to convert a 2D point into an isometric one.
    ///
    /// - Parameter point: The point to be converted to an isometric coordinate.
    /// - Returns: The point in the isometric grid.
    
    func convertToIsometricPoint(point: CGPoint) -> CGPoint {

        //invert y pre conversion
        var point = point * CGPoint(x:1, y:-1)

        //convert using algorithm
        point = CGPoint(x:(point.x - point.y), y: ((point.x + point.y) / 2))

        //invert y post conversion
        point = point * CGPoint(x:1, y:-1)

        return point

    }

    /// This function is used to convert an isometric point into a 2D one.
    ///
    /// - Parameter point: The point to be converted to a 2D coordinate.
    /// - Returns: The point in the 2D grid.
    
    func convertTo2dPoint(point: CGPoint) -> CGPoint {

        //invert y pre conversion
        var point = point * CGPoint(x:1, y:-1)

        //convert using algorithm
        point = CGPoint(x:((2 * point.y + point.x) / 2), y: ((2 * point.y - point.x) / 2))

        //invert y post conversion
        point = point * CGPoint(x:1, y:-1)

        return point

    }

    // MARK: Isometric tile placement

    func placeIsometricTile(image: String, atPosition point: CGPoint) {

        let tileSprite = SKSpriteNode(imageNamed: image)

        tileSprite.position = point
        tileSprite.anchorPoint = CGPoint(x:0, y:0)

        viewIso.addChild(tileSprite)
    }


    func buildIsometricScene() {

        for (rowNumber, row) in tiles.enumerated(){
            for (columnNumber, tileValue) in row.enumerated(){
                
                let tile = Tile(rawValue: tileValue)!
                
                let point = convertToIsometricPoint(point: CGPoint(x: (columnNumber * tileSize.width),
                                                                   y: -(rowNumber * tileSize.height)))
                
                placeIsometricTile(image: ("iso_"+tile.image), atPosition: point)

            
            }
        }
        
    }

    // MARK: 2D tile placement

    func place2dTile(image: String, atPosition point: CGPoint) {

        let tileSprite = SKSpriteNode(imageNamed: image)

        tileSprite.position = point
        tileSprite.anchorPoint = CGPoint(x:0, y:0)

        view2D.addChild(tileSprite)

    }

    func build2DScene() {

        for (rowNumber, row) in tiles.enumerated(){
            for (columnNumber, tileValue) in row.enumerated(){
                
                let tile = Tile(rawValue: tileValue)!
                let point = CGPoint(x: (columnNumber * tileSize.width),
                                    y: -(rowNumber * tileSize.height))
                
                place2dTile(image: tile.image, atPosition: point)

                
            }
        }

    }



}
