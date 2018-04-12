//
//  GameFieldPosition.swift
//  Blindspot
//
//  Created by Klemens Strasser on 18.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

public struct BSGameFieldPosition: Hashable {
    public var hashValue: Int
    
    public static func ==(lhs: BSGameFieldPosition, rhs: BSGameFieldPosition) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        
        hashValue = x * 100 + y;
    }
}

