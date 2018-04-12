//
//  Chapter.swift
//  Blindspot
//
//  Created by Klemens Strasser on 19.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit

public class CustomLevel: Chapter {
    
    var customNodes = Array<BSGameNodeDescription>()
    
    override public func getLevels() -> [[BSGameNodeDescription]] {
        return [customNodes]
    }
    
    public func addElement(type: BSGameNodeType, x: Int, y: Int) {
        
        guard x > 0 && y > 0 && x <= Constants.numberOfTiles && y <= Constants.numberOfTiles else {
            fatalError("Error! Coordinates have to be between 1 and 5!")
        }
        
        let fieldPosition = BSGameFieldPosition(x: x - 1, y: Constants.numberOfTiles - y)

        customNodes.append(BSGameNodeDescription(
            type: type,
            position: fieldPosition)
        )
    }
}
