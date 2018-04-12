//
//  BSGameFieldNode.swift
//  Blindspot
//
//  Created by Klemens Strasser on 18.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

public protocol BSGameFieldNodeDelegate {
    func levelCompleted()
}

public class BSGameFieldNode: SKSpriteNode {

    var gameNodes = Dictionary<BSGameFieldPosition, BSGameNode>()
    var floors = Dictionary<BSGameFieldPosition, BSFloorNode>()
    
    var startNode: BSStartNode?
    var characterNode: BSGameCharacter = BSGameCharacter(imageNamed: "Images/Character")
    
    var characterIsMoving = false
    
    public var guidedModeEnabled = false
    private var guidedNode: SKShapeNode!
    public var accessibilityModeEnabeld = true
    private var accessibilityHider: SKShapeNode?
    
    var delegate: BSGameFieldNodeDelegate!
    
    private var lastTouchededGameNode:BSGameNode?
    let synthesizer = AVSpeechSynthesizer()
    public var utteranceRate: Float = 0.5
    
    ////////////////////////////////////
    // MARK: Setup
    
    public func prepareGameField() {
        
        let fieldWidth = (Int)(self.size.width)
        let fieldHeight = (Int)(self.size.height)
        
        for x in 0..<Constants.numberOfTiles {
            for y in 0..<Constants.numberOfTiles {
                
                let fieldPosition = BSGameFieldPosition(x: x, y: y)
                let floorNode = BSFloorNode(fieldPosition: fieldPosition)
                
                let xPosition = x * Constants.tileSize + Constants.tileSize / 2
                let yPosition = y * Constants.tileSize + Constants.tileSize / 2
                
                floorNode.position = CGPoint(
                    x: xPosition - fieldWidth / 2,
                    y: yPosition - fieldHeight / 2)
                
                floors[fieldPosition] = floorNode
                
                self.addChild(floorNode)
            }
        }
        
        characterNode.zPosition = 10
        self.addChild(characterNode)
        
        // Needed
        let utterance = AVSpeechUtterance(string: "Let's go!")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = utteranceRate

        
        synthesizer.speak(utterance)
    }
    
    public func setAcessibility(enabled:Bool) {
        
        if(accessibilityHider == nil) {
            let color = UIColor(white: 38.0 / 255.0, alpha: 1.0)
            
            accessibilityHider = SKShapeNode(rect: self.frame)
            accessibilityHider?.fillColor = color
            accessibilityHider?.zPosition = 100;
            accessibilityHider?.strokeColor = color
            
            self.addChild(accessibilityHider!)
            
            
            guidedNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: Constants.tileSize, height: Constants.tileSize))
            guidedNode.alpha = 0.0
            guidedNode.strokeColor = UIColor.white
            guidedNode.lineWidth = 3.0
            guidedNode.fillColor = UIColor.clear
            guidedNode.zPosition = 110;
            self.addChild(guidedNode)
            
        }
        
        if(enabled && accessibilityHider != nil) {
            accessibilityHider?.alpha = 1.0
        } else {
            accessibilityHider?.alpha = 0.0
        }
        accessibilityModeEnabeld = enabled
    }
    
    public func setGuidedMode(enabled:Bool) {
        guidedModeEnabled = enabled
    }
    
    public func addElement(type: BSGameNodeType, x: Int, y: Int) {
    
        guard x < Constants.numberOfTiles && y < Constants.numberOfTiles else {
            print("Error: Faulty coordinates")
            return
        }
        
        let fieldPosition = BSGameFieldPosition(x: x, y: y)
        var gameNode: BSGameNode
        
        switch type {
        case .Start:
            startNode?.removeFromParent()
            
            startNode = BSStartNode(fieldPosition: fieldPosition)
            gameNode = startNode!
        case .End:
            gameNode = BSEndNode(fieldPosition: fieldPosition)
        case .Hole:
            gameNode = BSHoleNode(fieldPosition: fieldPosition)
        }
        
        if let floorNode = floors[fieldPosition]  {
            gameNode.position = floorNode.position
            self.addChild(gameNode)
            
            gameNodes[fieldPosition] = gameNode
            
            if(gameNode == startNode) {
                characterNode.position = floorNode.position
            }
        }
    }

    ////////////////////////////////////
    // MARK: User Interaction
    
    public func touchNode(position: CGPoint) {
        
        if let gameNode = self.gameNodeAt(xPosition: position.x, yPosition: position.y) {
            
            self.playDescriptionOfNode(gameNode: gameNode)
            
            if gameNode == startNode {
                characterIsMoving = true
            }
            
            if characterIsMoving && !accessibilityModeEnabeld {
                characterNode.position = position
            }
            
            lastTouchededGameNode = gameNode
            
            self.moveGuidedNode(nodePosition: gameNode.position)
        }
    }
    
    public func tryMovingCharacter(position: CGPoint) {
        
        guard let gameNode = self.gameNodeAt(xPosition: position.x, yPosition: position.y) else {return}
        guard characterIsMoving == true else {
            guard gameNode != lastTouchededGameNode && lastTouchededGameNode != nil else {return}
            // Swipe to locate
            lastTouchededGameNode = gameNode
            self.playDescriptionOfNode(gameNode: gameNode)
            return
        }
        
        if(lastTouchededGameNode != gameNode && !(gameNode is BSEndNode) && !(gameNode is BSHoleNode)) {
            self.playPosition(position:gameNode.gameFieldPosition)
            lastTouchededGameNode = gameNode
            self.moveGuidedNode(nodePosition: gameNode.position)
        }
        
        if (gameNode is BSFloorNode || gameNode is BSStartNode) && !accessibilityModeEnabeld {
            characterNode.position = position
        } else if gameNode is BSHoleNode {
            resetCharacterPosition()
            gameNode.playAudio()
            lastTouchededGameNode = nil
            synthesizer.stopSpeaking(at: .immediate)
        } else if gameNode is BSEndNode {
            characterNode.position = gameNode.position
            gameNode.playAudio()
            characterIsMoving = false
            lastTouchededGameNode = nil
            synthesizer.stopSpeaking(at: .immediate)
            delegate.levelCompleted()
            guidedNode.alpha = 0.0
        }
    }
    
    public func resetCharacterPosition() {
        guard characterIsMoving, let start = startNode else {return}
        
        let shrinkAction = SKAction.scale(to: 0.0, duration: 0.2)
        let resetAction = SKAction.run {
            self.characterNode.position = start.position
        }
        let scaleAction = SKAction.sequence(
            [SKAction.scale(to: 1.1, duration: 0.2),
             SKAction.scale(to: 1.0, duration: 0.2)])
        
        characterNode.run(SKAction.sequence([shrinkAction, resetAction, scaleAction]))
        characterIsMoving = false
    }
    
    public func playDescriptionOfNode(gameNode: BSGameNode) {
        
        var text:String
        text = gameNode.guidedModeDescription()
        self.playText(text:text)
    }
    
    public func playPosition(position: BSGameFieldPosition) {
        
        self.playText(text:"\(Constants.numberOfTiles - position.y) \(position.x + 1)")
    }
    
    public func playText(text:String) {
        synthesizer.stopSpeaking(at: .immediate)
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = utteranceRate
        
        synthesizer.speak(utterance)
    }

    
    public func playWinningSound() {
        playSound(fileName: "Winning.mp3")
    }
    
    public func fallOffTheField() {
        guard characterIsMoving else {return}
        
        self.resetCharacterPosition()
        playSound(fileName: "FallOff.wav")
    }
    
    func playSound(fileName: String) {
        let sound = SKAction.playSoundFileNamed("Sounds/" + fileName, waitForCompletion: false)
        self.run(sound)
    }
    
    func moveGuidedNode(nodePosition: CGPoint) {
        guard guidedModeEnabled else {return}
        
        guidedNode.alpha = 1.0
        guidedNode.position = CGPoint(x: nodePosition.x - (CGFloat)(Constants.tileSize / 2), y: nodePosition.y - (CGFloat)(Constants.tileSize / 2))
    }
    
    ////////////////////////////////////
    // MARK: Helpers
    
    private func gameNodeAt(xPosition: CGFloat, yPosition: CGFloat) -> BSGameNode? {
        let xCoordinate = CGFloat(Constants.tileSize * Constants.numberOfTiles) / 2 + xPosition
        let yCoordinate = CGFloat(Constants.tileSize * Constants.numberOfTiles) / 2 + yPosition
        
        let x = Int(xCoordinate) / Constants.tileSize
        let y = Int(yCoordinate) / Constants.tileSize
        
        let fieldPosition = BSGameFieldPosition(x: x, y: y)
        
        if let gameNode = gameNodes[fieldPosition] {
            return gameNode
        } else if let floor = floors[fieldPosition] {
            return floor
        } else {
            return nil
        }
    }
    
    public func clearField() {
        
        for node in gameNodes.values {
            node.removeFromParent()
        }
        gameNodes.removeAll()
    }
    
}
