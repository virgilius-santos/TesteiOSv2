//
//  ArrayExtensions.swift
//  SantanderSample
//
//  Created by Virgilius Santos on 20/04/19.
//  Copyright © 2019 Virgilius Santos. All rights reserved.
//

import Foundation

extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        
        return self[index]
    }
    
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
