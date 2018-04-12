//
//  BSEndNode.swift
//  Blindspot
//
//  Created by Klemens Strasser on 19.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit

class BSEndNode: BSGameNode {
    
    override var text: String {
        set {}
        get {
            return "End "
        }
    }
    
    convenience init(fieldPosition: BSGameFieldPosition) {
        self.init(spriteName: "End", fieldPosition: fieldPosition)
    }
}
