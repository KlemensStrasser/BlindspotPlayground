//
//  BSTextInfoNode.swift
//  Blindspot
//
//  Created by Klemens Strasser on 19.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

public class BSTextInfoNode: SKShapeNode, AccessibilityNode {

    public var utteranceRate:Float = 0.5
    private let synthesizer = AVSpeechSynthesizer()
    private var text = "You've finished this page. Please continue with the next one"
    
    public func setStandardText() {
        text = "You've finished this page. Please continue with the next one"
    }
    
    public func setWWDCText() {
        text = "That's it! Thank's for playing and I hope to see you at dub dub DC 2018"
    }
    
    public func setEditorText() {
        text = "Nice level! Build another one or continue with the next page"
    }
    
    public func setErrorText() {
        text = "Sorry, but this level is not playable. You either forgot to add an start or an end element!"
    }
    
    public func setOutsideText() {
        text = "Outside"
    }
    
    public func setLastPageText() {
        text = "Well done! You really seem to love a challenge!"
    }
    
    public func getCurrentText() -> String {
        return text
    }
    
    public func playDescription() {
        
        if synthesizer.isSpeaking  {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = utteranceRate
        
        synthesizer.speak(utterance)
    }
}
