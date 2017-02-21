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
        case door
    }

    var interactionType: InteractionType = .transportable

    fileprivate var stateStorage: TileState = .inactive

    var currentState: TileState{
        get{
            return stateStorage
        }
        set{
            DispatchQueue.main.async{
                if self.interactionType == .animatable{
                    self.texture = self.textureStorage[newValue]
                }
            }
            self.stateStorage = newValue
        }

    }

    var textureStorage: [TileState : SKTexture] = [:]

    var childNode: SKSpriteNode?
    var secondaryNode: SKShapeNode?

    var activateAction: (() -> ())?
    var deactivateAction: (() -> ())?
    
    init(textures: [TileState : SKTexture] = [.inactive : SKTexture.init(imageNamed: "iso_ground")],
         tileDepth: Int = 0,
         tileHeight: TileHeight = .fullHeight,
         interactionType: InteractionType = .transportable,
         activateAction: @escaping (() -> ()) = {_ in},
         deactivateAction: @escaping (() -> ()) = {_ in}){
        

        self.textureStorage = textures
        self.interactionType = interactionType
        self.activateAction = activateAction
        self.deactivateAction = deactivateAction


        if interactionType == .transportable {

            if let childTexture = textures[.inactive]{

                let childSize = childTexture.size()

                //HACK HACK HACK
                //TODO: Reimplement this by calculating a size multiplier from both the texture and the baseSize
                //instead of just dividing everyone by 2 for @2x.
                
                secondaryNode = SKShapeNode.init(ellipseOf: CGSize(width: childSize.width / 2,
                        height: (childSize.height / 4)))
                secondaryNode?.strokeColor = UIColor.clear
                secondaryNode?.fillColor = UIColor.darkGray
                secondaryNode?.alpha = 0


                let size = CGSize.init(width: childSize.width / 2, height: childSize.height / 2)

                self.childNode = SKSpriteNode.init(texture: childTexture,
                        color: UIColor.clear,
                        size: size)

                if let localChild = childNode{

                    localChild.zPosition = 1

                    super.init(spriteTexture: nil,
                            tileDepth: tileDepth,
                            accessible: false,
                            tileHeight: tileHeight)

                    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    localChild.anchorPoint = CGPoint(x: 0.5, y: 0.5)

                    localChild.position = CGPoint(x: (self.position.x + (self.size.width / 2)),
                            y: (self.position.y + ((self.size.width / 10) * 3)))
                    secondaryNode?.position = CGPoint(x: (self.position.x + (self.size.width / 2)),
                            y: (self.position.y + ((self.size.width / 10) * 2)))

                    print(self.position, localChild.position)

                    self.addChild(localChild)
                    self.addChild(secondaryNode!)

                    print(self.size)
                    print(self.anchorPoint)

                } else {

                    print("Unrecoverable error at:", #file, #function, #line)
                    abort()

                }


            } else{

                super.init(spriteTexture: nil,
                        tileDepth: tileDepth,
                        accessible: false,
                        tileHeight: tileHeight)


            }


        } else {

            super.init(spriteTexture: textures[.inactive],
                    tileDepth: tileDepth,
                    accessible: false,
                    tileHeight: tileHeight)
            

        }
        
        let identifier = Notification.Name.init(rawValue: NotificationIdentifiers.tilePositionChanged.rawValue)
        NotificationCenter.default.addObserver(forName: identifier,
                                               object: nil,
                                               queue: nil) { (notification) in
                                                self.handleNotification(notification)
        }
        
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
            self.childNode?.run(sequence)
        }

    }

    func activate(){
        if self.interactionType == .transportable {
            DispatchQueue.main.async {
                let moveAction = SKAction.moveBy(x: 0, y: self.hoverOffset(), duration: 0.4)
                self.childNode?.run(moveAction)

                let appearAction = SKAction.fadeAlpha(to: 0.5, duration: 0.4)
                self.secondaryNode?.run(appearAction)
            }
        } else if self.interactionType == .door{
            if let scene = self.scene as? IsometricGameScene{
                
                //FIXME: Move calculatePoint to the tile context, instead of the scene context.
                
                let newPoint = scene.calculatePoint(for: self,
                                                    atPosition: CGPoint(x: self.gridPosition.x, y: self.gridPosition.y + 1),
                                                    onLayer: self.gridPosition.z)
                
                let moveAction = SKAction.move(to: newPoint, duration: 0.4)
                
                DispatchQueue.main.async {
                    self.run(moveAction, completion: { 
                        self.isAccessible = true
                    })
                }

            }

        }

        ///run custom operator...
        self.activateAction?()

    }
    
    func deactivate(){

        if self.interactionType == .transportable{
            DispatchQueue.main.async {
                let moveAction = SKAction.moveBy(x: 0, y: (-1 * self.hoverOffset()), duration: 0.4)
                self.childNode?.run(moveAction)

                let appearAction = SKAction.fadeAlpha(to: 0, duration: 0.4)
                self.secondaryNode?.run(appearAction)
            }
        } else if self.interactionType == .door{
            if let scene = self.scene as? IsometricGameScene{
                let newPoint = scene.calculatePoint(for: self,
                                                    atPosition: CGPoint(x: self.gridPosition.x, y: self.gridPosition.y),
                                                    onLayer: self.gridPosition.z)
                let moveAction = SKAction.move(to: newPoint, duration: 0.4)
                
                DispatchQueue.main.async {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { 
                        self.run(moveAction, completion: {
                            self.isAccessible = false
                            
                        })
                    })
                }

            }
            
        }

        ///run custom operator...
        self.deactivateAction?()
    }
    
    func handleNotification(_ notification: Notification){
        if let newPosition = notification.userInfo?["newPosition"] as? (x: Int, y: Int, z: Int){
            if self.abovePosition() == newPosition{
                self.currentState = .interacting
                activateAction?()
            } else{
                self.currentState = .inactive
                deactivateAction?()
            }
        }
    }

    func hoverOffset() -> CGFloat{

        if let childNode = self.childNode{
            return (SKInteractiveNode.baseSize.height / 2) - childNode.size.height
        } else {
            return 42
        }

    }


}

