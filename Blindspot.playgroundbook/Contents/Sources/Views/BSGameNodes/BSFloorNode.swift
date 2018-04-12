//
//  BSFloorNode.swift
//  Blindspot
//
//  Created by Klemens Strasser on 18.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit
import SpriteKit

class BSFloorNode: BSGameNode {

    override var text: String {
        set {}
        get {
            return "Floor"
        }
    }
    
    convenience init(fieldPosition: BSGameFieldPosition) {
        self.init(spriteName: "Floor", fieldPosition: fieldPosition)
    }
    
    override public func normalDescription() -> String {
        return ""
    }
}
