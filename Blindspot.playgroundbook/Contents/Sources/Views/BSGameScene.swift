//
//  GameScene.swift
//  Blindspot
//
//  Created by Klemens Strasser on 18.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import SpriteKit
import PlaygroundSupport

public class BSGameScene: SKScene, BSGameFieldNodeDelegate {
    
    private var label : SKLabelNode!
    private var spinnyNode : SKShapeNode!
    
    private var fieldNode: BSGameFieldNode?
    private var completionNode: BSTextInfoNode?
    private var outsideNode: BSTextInfoNode?
    
    private var interactable: Bool = true
    private var gameFinished: Bool = false
    
    private var levels: [[BSGameNodeDescription]]?
    private var currentLevelIndex = 0
    
    ////////////////////////////////////
    // MARK: Setup
    
    public func setupGameField() {
        
        if(fieldNode == nil) {
            fieldNode = BSGameFieldNode(color: UIColor.white, size: self.size)
            fieldNode!.prepareGameField()
            fieldNode?.delegate = self
            
            outsideNode = BSTextInfoNode(rect: CGRect(x: 0, y: 0, width: 0, height: 0))
            outsideNode!.zPosition = -10
            outsideNode!.setOutsideText()
            self.addChild(outsideNode!)
            
            completionNode = BSTextInfoNode(rect: self.frame)
            completionNode?.strokeColor = UIColor(white: 38.0 / 255.0, alpha: 1.0)
            completionNode?.setStandardText()
            
            self.addChild(fieldNode!)
        } else {
            fieldNode!.clearField()
        }
    }
    
    public func setChapter(chapter: Chapter) {
        levels = chapter.getLevels()
        
        if(chapter is CustomLevel) {
            completionNode?.setEditorText()
        }
        
        if(chapter is GoodBye) {
            completionNode?.setWWDCText()
            self.addChild(completionNode!)
            
            gameFinished = true
            
        } else {
            let levelsAreValid = self.checkIfLevelsAreValid()
            
            if(levelsAreValid) {
                self.addNodesWith(descriptions: levels![currentLevelIndex])
            } else {
                completionNode?.setErrorText()
                self.addChild(completionNode!)
                fieldNode?.playText(text: completionNode!.getCurrentText())
//                completionNode?.playDescription()
            }
        }
        

    }
    
    func checkIfLevelsAreValid() -> Bool {
        
        var levelsAreValid = levels!.count > 0
        
        for level in levels! {
            
            var numberOfStarts = 0
            var numberOfEnds = 0
            
            for nodeDescription in level {
                
                if nodeDescription.type == .End {
                    numberOfEnds += 1
                } else if nodeDescription.type == .Start {
                    numberOfStarts += 1
                }
            }
            
            if numberOfEnds == 0 || numberOfStarts == 0 {
                levelsAreValid = false
                break
            }
            
        }
        
        return levelsAreValid
    }
    
    func addNodesWith(descriptions: [BSGameNodeDescription]) {
        
        for description in descriptions {
            fieldNode?.addElement(
                type: description.type,
                x: description.position.x,
                y: description.position.y)
        }
    }
    
    public func setAcessibility(enabled: Bool) {
        
        fieldNode?.setAcessibility(enabled: enabled)
    }
    
    public func setGuidedMode(enabled: Bool) {
        
        fieldNode?.setGuidedMode(enabled: enabled)
    }
    
    public func setVoicePlaybackSpeed(voicePlaybackSpeed: Double) {
        
        fieldNode?.utteranceRate = (Float)(voicePlaybackSpeed)
        completionNode?.utteranceRate = (Float)(voicePlaybackSpeed)
        outsideNode?.utteranceRate = (Float)(voicePlaybackSpeed)
    }
    
    public func setCompletionNodeLastPageText() {
        completionNode?.setLastPageText()
    }
    
    
    ////////////////////////////////////
    // MARK: Getter

    public func AccessibilityModeEnabled() -> Bool {
        
        if(fieldNode != nil) {
            return fieldNode!.accessibilityModeEnabeld
        } else {
            return true
        }
    }
    
    ////////////////////////////////////
    // MARK: User Interaction
    
    func touchDown(atPoint pos : CGPoint) {
        guard(!gameFinished) else {
//            completionNode?.playDescription()
            fieldNode?.playText(text: completionNode!.getCurrentText())
            return
        }
        
        if(self.fieldNode!.frame.contains(pos)) {
            fieldNode?.touchNode(position: pos)
        } else {
//            outsideNode?.playDescription()
            fieldNode?.playText(text: outsideNode!.getCurrentText())
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        guard(!gameFinished) else {return}
        
        if(self.fieldNode!.frame.contains(pos)) {
            fieldNode?.tryMovingCharacter(position: pos)
        } else {
            fieldNode?.fallOffTheField()
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        guard(!gameFinished) else {return}
        
        fieldNode?.resetCharacterPosition()
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, interactable else {return}
        touchDown(atPoint: touch.location(in: self))
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, interactable else {return}
        touchMoved(toPoint: touch.location(in: self))
    
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, interactable else {return}
        touchUp(atPoint: touch.location(in: self))
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, interactable else {return}
        touchUp(atPoint: touch.location(in: self))
    }

    
    
    ////////////////////////////////////
    // MARK: BSGameFieldNodeDelegate
    
    public func levelCompleted() {
        
        fieldNode?.playWinningSound()
        currentLevelIndex += 1
        
        if levels != nil && currentLevelIndex < (levels?.count)! {
            fieldNode?.clearField()
            addNodesWith(descriptions: levels![currentLevelIndex])
            
        } else {
            gameFinished = true
            if(completionNode != nil) {
                self.addChild(completionNode!)
                if let handler = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
                    let dict = PlaygroundValue.dictionary([
                        Constants.levelFinishedKey: PlaygroundValue.boolean(true)])
                    
                    handler.send(dict)
                }
                
                fieldNode?.playText(text: completionNode!.getCurrentText())
            }
        }
    }
    
}
