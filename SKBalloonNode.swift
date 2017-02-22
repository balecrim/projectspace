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
    
    var textStorage: String = ""
    
    var text: String{
        get{ return textStorage }
        set{
            self.textStorage = newValue
        }
    }

    init(text: String = "",
         color: UIColor? = nil,
         size: CGSize = SKBalloonNode.defaultTexture.size()) {
        
        super.init(texture: SKBalloonNode.defaultTexture,
                   color: .clear,
                   size: SKBalloonNode.defaultTexture.size())
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateImage(for text: String, frame: CGRect) -> UIImage{
        let label = UILabel.init(frame: frame)
        
        label.text = text
        label.textColor = UIColor.white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 4
        label.textAlignment = .center

        return label.toImage()
    }
    
    func time(for text: String) -> Double{
        
        //0.6 seconds per word is a healthy median.
        
        return 0.6 * Double(text.components(separatedBy: " ").count)
    }
    
}
