//
//  UIView+toImage.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/21/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func toImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}

