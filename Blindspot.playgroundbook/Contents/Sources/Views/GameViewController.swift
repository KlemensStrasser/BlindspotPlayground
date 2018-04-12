//
//  ViewController.swift
//  Blindspot
//
//  Created by Klemens Strasser on 18.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import UIKit
import SpriteKit
import PlaygroundSupport

public class GameViewController: UIViewController, PlaygroundLiveViewSafeAreaContainer, PlaygroundLiveViewMessageHandler {

    public var gameView: SKView = SKView(frame: CGRect(x:0, y:0, width: 420, height: 420))
    public var gameScene: BSGameScene?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(gameView)
        
        self.view.isAccessibilityElement = true
        self.view.accessibilityTraits = UIAccessibilityTraitAllowsDirectInteraction
        gameView.isAccessibilityElement = true
        gameView.accessibilityTraits = UIAccessibilityTraitAllowsDirectInteraction
    }
    
    public func setUpGameScene() -> BSGameScene? {
        guard let scene = BSGameScene(fileNamed: "BSGameScene") else { return nil }
        gameScene = scene
    
        gameView.presentScene(scene)
        scene.setupGameField()
//        scene.scaleMode = .aspectFit
    
        return gameScene
    }
    
    ////////////////////////
    // MARK: PlaygroundLiveViewMessageHandler
    
    public func receive(_ message: PlaygroundValue) {
        
        guard case let .dictionary(dict) = message else {return}
        
        if case let .boolean(enabled)? = dict[Constants.visualRepresentationEnabledKey] {
            if(!enabled && self.gameScene != nil) {
                self.gameScene?.setAcessibility(enabled:true)
            } else if(enabled && self.gameScene != nil) {
                self.gameScene?.setAcessibility(enabled: false)
            }
        }
        
        if case let .boolean(enabled)? = dict[Constants.guidedModeEnabledKey] {
            if(self.gameScene != nil) {
                self.gameScene?.setGuidedMode(enabled:enabled)
            }
        }
        
        if case let .floatingPoint(voicePlaybackSpeed)? = dict[Constants.voicePlaybackSpeedKey] {
            if(self.gameScene != nil) {
                self.gameScene!.setVoicePlaybackSpeed(voicePlaybackSpeed:voicePlaybackSpeed)
            }
        }
    }
    
}
