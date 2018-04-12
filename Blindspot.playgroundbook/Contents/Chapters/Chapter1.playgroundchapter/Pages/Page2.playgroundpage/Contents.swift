/*:
 # Blind
 
 The previous page is just there to make the game easy understandable in a short amount of time. The actual idea for the playground was to design a game that is playable by blind people.
 
 You will now get the same levels as before, but you will have to solve them without seeing anything. To find the elements, tap on the screen and the game will tell you what you have touched and where it is.
 
 - Note:
 
    - The game tells you your current position during the drag.
 
    - Every tile is approximetly as wide as your index finger. 
 
    - If you touch outside the 5x5 field, the game will tell you that.
 
    - If you drag the chracter off the field, you will hear a sound and the character will be reset to the start.
 
 * Callout(Paramters):
 With the paramters below, you can reenable the visual representation, change the talking speed or enable the guided mode. When the latter is turned on, the game will show an white rectangle around the touched element. If you change any parameter, you have to click on "Run My Code" to submit your changes.
 */
//#-hidden-code
import PlaygroundSupport
var visualRepresenationEnabled:Bool = false
var guidedModeEnabled:Bool = false
var voicePlaybackSpeed:Double = 0.5
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, true, false)
//#-end-hidden-code
visualRepresenationEnabled = /*#-editable-code visual representation*/false/*#-end-editable-code*/
guidedModeEnabled = /*#-editable-code guided mode representation*/false/*#-end-editable-code*/
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
//: [Next Page](@next)
