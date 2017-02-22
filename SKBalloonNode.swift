//
//  SKBalloonNode.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/21/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

//FIXME: My itchy merge finger.
//in memoriam of my patience, since because I screwed up (AGAIN!),
//I have to reimplement this entirely.

//Lessons learned: commit more frequently, test more, screw up less.

class SKBalloonNode: SKSpriteNode{
    
    static let defaultTexture = SKTexture.init(imageNamed: "balloon")
    static let offset = CGSize(width: 10, height: 30)
    
    var textStorage: String = ""
    var textQueue: [String] = []
    
    var text: String{
        get{ return textStorage }
        set{
            self.textStorage = newValue
            updateText(with: newValue)
        }
    }

    init(text: String = "",
         color: UIColor? = nil,
         size: CGSize = SKBalloonNode.defaultTexture.size()) {
        
        super.init(texture: SKBalloonNode.defaultTexture,
                   color: .clear,
                   size: SKBalloonNode.defaultTexture.size())
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildTextNode(for text: String, with size: CGSize) -> SKSpriteNode{
        let textImage = generateImage(for: text,
                                      frame: CGRect.init(x:0, y:0,
                                                         width:size.width,
                                                         height:size.height))
        
        let childTexture = SKTexture.init(image: textImage)
        
        
        let node = SKSpriteNode.init(texture: childTexture,
                                     color: .clear,
                                     size: childTexture.size())
        
        
        return node
    }
    
    private func generateImage(for text: String, frame: CGRect) -> UIImage{
        let label = UILabel.init(frame: frame)
        
        label.isOpaque = false
        
        label.text = text
        label.textColor = UIColor.white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 4
        label.textAlignment = .center

        return label.toImage()
    }

    fileprivate func updateText(with text: String){

        let childNode = buildTextNode(for: text,
                                      with: CGSize(width: self.size.width - SKBalloonNode.offset.width,
                                                   height: self.size.height - SKBalloonNode.offset.height))
        
        childNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        childNode.position = CGPoint(x: 0, y: 30)
        childNode.name = "textNode"
        childNode.zPosition = 103
        childNode.alpha = 0
        
        let fadeOutAction = SKAction.fadeAlpha(to: 0, duration: 0.15)
        let fadeInAction = SKAction.fadeAlpha(to: 1, duration: 0.15)
        
        if let oldNode = self.childNode(withName: "textNode"){
            DispatchQueue.main.async {
                oldNode.run(fadeOutAction, completion: {_ in
                    oldNode.removeFromParent()
                    self.addChild(childNode)
                    childNode.run(fadeInAction)
                })
            }
        } else {
            DispatchQueue.main.async {
                self.addChild(childNode)
                childNode.run(fadeInAction)
            }
        }

    }
    
    func show(for sequence: [String]){
        if let currentString = sequence.first{
            appear()
            
            DispatchQueue.main.async {
                self.text = currentString
                
                DispatchQueue.global()
                    .asyncAfter(deadline: DispatchTime.now() + self.time(for: currentString),
                                execute: {
                                    let newSequence = Array(sequence.dropFirst())
                                    self.show(for: newSequence)
                    })
            }

        } else{
            disappear()
        }
        
        
    }
    
    fileprivate func appear(){
        if alpha != 1{
            let fadeInAction = SKAction.fadeAlpha(to: 1, duration: 0.15)
            
            DispatchQueue.main.async {
                self.run(fadeInAction)
            }
        }
    }
    
    fileprivate func disappear(){
        if alpha != 0{
            let fadeOutAction = SKAction.fadeAlpha(to: 0, duration: 0.15)
            
            DispatchQueue.main.async {
                self.run(fadeOutAction, completion: { 
                    self.text = ""
                })
            }
        }
    }

    
    
    fileprivate func time(for text: String) -> Double{
        
        //0.6 seconds per word is a healthy median.
        
        let time = 0.1 * Double(text.characters.count)
    
        if time < 3{
            return 3
        } else {
            return time
        }
        
    }
    
}
