//
//  BSStartNode.swift
//  Blindspot
//
//  Created by Klemens Strasser on 19.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit

class BSStartNode: BSGameNode {
    
    override var text: String {
        set {}
        get {
            return "Start"
        }
    }
    
    convenience init(fieldPosition: BSGameFieldPosition) {
        self.init(spriteName: "Start", fieldPosition: fieldPosition)
    }
}
