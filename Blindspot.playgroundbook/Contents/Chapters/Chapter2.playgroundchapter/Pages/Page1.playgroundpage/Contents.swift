/*:
 # Holes
 
 This chapter features holes. If you drag the character into a hole, the character will be reset and you have to start again.
 
 Again: To help you locate the elements, the game will tell you if tap on one.
 
 Good Luck! 😊
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
PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
/*:
- Note:
 There are even harder levels that you can check out in the [B-Sides](Chapter4/Page2) page of the last chapter.
*/

//: [Next Page](@next)
