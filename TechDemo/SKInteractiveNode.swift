//
//  SKInteractiveNode.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/16/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics

class SKInteractiveNode: SKTileNode{
    
    enum TileState {
        case inactive
        case interacting
        case objectiveFulfilled
    }
    
    enum InteractionType{
        case transportable
        case animatable
    }
    
    var currentState: TileState = .inactive
    var childNode: SKSpriteNode
    var secondaryNode: SKShapeNode?
    
    init(spriteTexture: SKTexture = SKTexture.init(imageNamed: "iso_ground"),
         tileDepth: Int = 0,
         tileHeight: TileHeight = .fullHeight){
        
        secondaryNode = SKShapeNode.init(ellipseOf: CGSize(width: spriteTexture.size().width,
                                                           height: (spriteTexture.size().height / 2)))
        secondaryNode?.strokeColor = UIColor.clear
        secondaryNode?.fillColor = UIColor.darkGray
        secondaryNode?.alpha = 0
        
        
        childNode = SKSpriteNode.init(texture: spriteTexture,
                                      color: UIColor.clear,
                                      size: spriteTexture.size())
        childNode.zPosition = 1
        

        
        super.init(spriteTexture: nil,
                   tileDepth: tileDepth,
                   accessible: false,
                   tileHeight: tileHeight)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        childNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        childNode.position = CGPoint(x: (self.position.x + (self.size.width / 2)),
                                     y: (self.position.y + ((self.size.width / 10) * 3)))
        secondaryNode?.position = CGPoint(x: (self.position.x + (self.size.width / 2)),
                                          y: (self.position.y + ((self.size.width / 10) * 2)))
        
        print(self.position, childNode.position)
        
        self.addChild(childNode)
        self.addChild(secondaryNode!)
//        self.color = UIColor.red

        print(self.size)
        print(self.anchorPoint)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        childNode = SKSpriteNode.init()
        super.init(coder: aDecoder)
    }

    func hint(){
        
        DispatchQueue.main.async {
            let colorize = SKAction.colorize(with: UIColor.orange, colorBlendFactor: 0.6, duration: 0.4)
            let wait = SKAction.wait(forDuration: 0.1)
            let decolorize = SKAction.colorize(withColorBlendFactor: 0, duration: 0.4)
            
            let sequence = SKAction.sequence([colorize, wait, decolorize])
            self.childNode.run(sequence)
        }

    }

    func activate(){
        DispatchQueue.main.async {
            let moveAction = SKAction.moveBy(x: 0, y: self.hoverOffset(), duration: 0.4)
            self.childNode.run(moveAction)
            
            let appearAction = SKAction.fadeAlpha(to: 0.5, duration: 0.4)
            self.secondaryNode?.run(appearAction)
        }
    }
    
    func deactivate(){
        let moveAction = SKAction.moveBy(x: 0, y: (-1 * hoverOffset()), duration: 0.4)
        childNode.run(moveAction)
        
        let appearAction = SKAction.fadeAlpha(to: 0, duration: 0.4)
        secondaryNode?.run(appearAction)
        
    }

    func hoverOffset() -> CGFloat{
        
        return (SKInteractiveNode.baseSize.height / 2) - childNode.size.height
    }


}

