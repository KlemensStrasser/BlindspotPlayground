//
//  ViewController.swift
//  Blindspot
//
//  Created by Klemens Strasser on 18.03.18.
//  Copyright © 2018 Tardigrade. All rights reserved.
//

import PlaygroundSupport

public class Listener: PlaygroundRemoteLiveViewProxyDelegate {
    
    public static let shared = Listener()
    
    private var isLastPage = false
    
    public func setup() {
        if let proxy = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy {
            proxy.delegate = self
        }
    }
    
    public func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy,
                             received message: PlaygroundValue) {
        
        guard case let .dictionary(dict) = message else { return }
        
        if case .boolean(_)? = dict[Constants.levelFinishedKey] {
            var meassage = "Awesome! You did it 😊! Continue with the [next page](@next)"
            
            if(isLastPage) {
                meassage = "You did it 😊! That was all I had to offer, thanks for playing!"
            }
            
            PlaygroundPage.current.assessmentStatus = .pass(message: meassage)
        }
    }
    
    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {
        // TODO?
    }
    
    public func setIsLastPage() {
        isLastPage = true
    }
}
