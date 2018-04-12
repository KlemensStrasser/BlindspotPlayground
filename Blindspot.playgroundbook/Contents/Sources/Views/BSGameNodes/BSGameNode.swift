//
//  BSGameNode.swift
//  Blindspot
//
//  Created by Klemens Strasser on 18.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit
import SpriteKit

public protocol AccessibilityNode {
    func playDescription()
}

public class BSGameNode: SKSpriteNode {
    
    public var gameFieldPosition: BSGameFieldPosition
    var audioFileName: String?
    var text: String {
        set {}
        get {
            return ""
        }
    }

    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        
        self.gameFieldPosition = BSGameFieldPosition(x: 0, y: 0)
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience public init(spriteName: String, fieldPosition: BSGameFieldPosition) {
        let texture = SKTexture(imageNamed: "Images/" + spriteName)
        self.init(texture:texture, color: SKColor.white, size: texture.size())
        
        self.gameFieldPosition = fieldPosition
    }
    
    required public init?(coder aDecoder: NSCoder) {
        // Decoding length here would be nice...
        self.gameFieldPosition = BSGameFieldPosition(x: 0, y: 0)
        super.init(coder: aDecoder)
    }
    
    ////////////////////////////////////
    // MARK: User Interaction
    
    public func normalDescription() -> String {
        return text
    }
    
    
    public func guidedModeDescription() -> String {
        let guidedDescription = text + " at: \(Constants.numberOfTiles - gameFieldPosition.y) \(gameFieldPosition.x + 1)"
        return guidedDescription
    }
    
    func playAudio() {
        if(audioFileName != nil) {
            let sound = SKAction.playSoundFileNamed(audioFileName!, waitForCompletion: false)
            self.run(sound)
        }
    }
}
