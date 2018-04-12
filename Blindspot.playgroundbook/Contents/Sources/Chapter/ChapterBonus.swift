//
//  Chapter1.swift
//  Blindspot
//
//  Created by Klemens Strasser on 19.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit

public class ChapterBonus: Chapter {
    
    override public var level1: [BSGameNodeDescription] {
        get {
            return [
                BSGameNodeDescription(
                    type: .Start,
                    position: BSGameFieldPosition(x: 0, y: 0)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 1, y: 0)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 1, y: 1)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 1, y: 2)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 1, y: 3)),
                
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 2, y: 3)),
                
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 3, y: 1)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 3, y: 2)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 3, y: 3)),

                BSGameNodeDescription(
                    type: .End,
                    position: BSGameFieldPosition(x: 2, y: 2))
            ]
        }
    }
    
    override public var level2: [BSGameNodeDescription] {
        get {
            return [
                BSGameNodeDescription(
                    type: .Start,
                    position: BSGameFieldPosition(x: 1, y: 0)),
                
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 0, y: 2)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 1, y: 1)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 1, y: 3)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 3, y: 1)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 3, y: 3)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 5, y: 0)),
                
                BSGameNodeDescription(
                    type: .End,
                    position: BSGameFieldPosition(x: 4, y: 3))
            ]
        }
    }

    override public var level3: [BSGameNodeDescription] {
        get {
            
            return [
                BSGameNodeDescription(
                    type: .Start,
                    position: BSGameFieldPosition(x: 0, y: 3)),
                
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 0, y: 2)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 1, y: 1)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 1, y: 3)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 2, y: 3)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 3, y: 0)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 3, y: 2)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 4, y: 0)),
                BSGameNodeDescription(
                    type: .Hole,
                    position: BSGameFieldPosition(x: 4, y: 4)),
                
                BSGameNodeDescription(
                    type: .End,
                    position: BSGameFieldPosition(x: 0, y: 1))
            ]

        }
    }
    
}
