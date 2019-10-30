//
//  Collections.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/14/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    
    /// Safely access an item at an index using optionals.
    /// Why isn't this the standard?
    
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
