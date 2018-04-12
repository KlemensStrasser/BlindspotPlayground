//
//  Chapter.swift
//  Blindspot
//
//  Created by Klemens Strasser on 19.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit

public protocol ChapterProtocol {
    
    var level1: [BSGameNodeDescription] {get}
    var level2: [BSGameNodeDescription] {get}
    var level3: [BSGameNodeDescription] {get}
}

public class Chapter: ChapterProtocol {
    
    public init() {
        
    }
    
    public var level1: [BSGameNodeDescription] {
        get {
            return []
        }
    }
    
    public var level2: [BSGameNodeDescription] {
        get {
            return []
        }
    }
    
    public var level3: [BSGameNodeDescription] {
        get {
            return []
        }
    }
    
    public func getLevels() -> [[BSGameNodeDescription]] {
        
        return [level1, level2, level3]
    }
    
    
}
