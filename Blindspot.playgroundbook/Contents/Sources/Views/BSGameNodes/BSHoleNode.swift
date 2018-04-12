//
//  BSHoleNode.swift
//  Blindspot
//
//  Created by Klemens Strasser on 19.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit
import SpriteKit

class BSHoleNode: BSGameNode {

    override var audioFileName: String? {
        set {}
        get {
            return "Sounds/Falldown.mp3"
        }
    }
    
    override var text: String {
        set {}
        get {
            return "Hole "
        }
    }
    
    convenience init(fieldPosition: BSGameFieldPosition) {
        self.init(spriteName: "Hole", fieldPosition: fieldPosition)
    }
}
