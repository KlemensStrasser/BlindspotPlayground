/*:
 # B-Sides
 
 Here are some harder levels that feature holes. Good luck! 😈
 */
//#-hidden-code
import PlaygroundSupport
var visualRepresenationEnabled:Bool = false
var guidedModeEnabled:Bool = false
var voicePlaybackSpeed:Double = 0.5
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, true, false)
//#-end-hidden-code
guidedModeEnabled = /*#-editable-code number of repetitions*/false/*#-end-editable-code*/
visualRepresenationEnabled = /*#-editable-code number of repetitions*/false/*#-end-editable-code*/
voicePlaybackSpeed = /*#-editable-code playback speed*/0.5/*#-end-editable-code*/
//#-hidden-code
if let proxy = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy {
    
    let dict = PlaygroundValue.dictionary([
        Constants.visualRepresentationEnabledKey: PlaygroundValue.boolean(visualRepresenationEnabled),
        Constants.guidedModeEnabledKey: PlaygroundValue.boolean(guidedModeEnabled),
        Constants.voicePlaybackSpeedKey: PlaygroundValue.floatingPoint(voicePlaybackSpeed)])
    
    proxy.send(dict)
}

Listener.shared.setup()
Listener.shared.setIsLastPage()
PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
