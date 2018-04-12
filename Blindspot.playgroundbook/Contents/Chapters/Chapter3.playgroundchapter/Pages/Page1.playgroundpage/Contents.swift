/*:
 
 # Level Editor

 This pages allows you to create your own level. The elements are placed on a 5x5 grid, with the top left being (1,1), the bottom left (5,1).
 
 Have fun ☺️
*/
//#-hidden-code
import PlaygroundSupport
import SpriteKit

let vc = GameViewController()

vc.setUpGameScene()
let gameView = vc.gameView

gameView.clipsToBounds = true
gameView.translatesAutoresizingMaskIntoConstraints = false

NSLayoutConstraint.activate([
    gameView.leadingAnchor.constraint(equalTo: vc.liveViewSafeAreaGuide.leadingAnchor),
    gameView.trailingAnchor.constraint(equalTo: vc.liveViewSafeAreaGuide.trailingAnchor),
    gameView.topAnchor.constraint(equalTo: vc.liveViewSafeAreaGuide.topAnchor),
    gameView.bottomAnchor.constraint(equalTo: vc.liveViewSafeAreaGuide.bottomAnchor)
    ])

var visualRepresenationEnabled:Bool = false
var guidedModeEnabled:Bool = false
var voicePlaybackSpeed:Double = 0.5
var level:CustomLevel = CustomLevel()

let gameScene = vc.gameScene

func addElement(type: BSGameNodeType, x: Int, y: Int) {
    level.addElement(type:type, x:x, y:y)
}

//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-code-completion(identifier, hide, gameScene, gameView, level, vc, visualRepresenationEnabled, guidedModeEnabled)
//#-code-completion(identifier, show, Hole, End)
//#-code-completion(identifier, show, .)

//#-end-hidden-code
/*:
 - Note:
   For the game to work, you have to have one start and at least one end-element.
 */

addElement(type: .Start, x: /*#-editable-code x-Coordinate*/1/*#-end-editable-code*/, y: /*#-editable-code y-Coordinate*/3/*#-end-editable-code*/)
addElement(type: .End, x: /*#-editable-code x-Coordinate*/5/*#-end-editable-code*/, y: /*#-editable-code y-Coordinate*/3/*#-end-editable-code*/)

/*:
 - Example: *How to add an hole element*\
 `addElement(type: .Hole, x: 3, y: 3)`
 */

//#-editable-code Tap to write your code
//#-end-editable-code

/*:
 You can set the same parameters as always:
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, true, false)
//#-end-hidden-code
guidedModeEnabled = /*#-editable-code number of repetitions*/false/*#-end-editable-code*/
visualRepresenationEnabled = /*#-editable-code number of repetitions*/false/*#-end-editable-code*/
voicePlaybackSpeed = /*#-editable-code playback speed*/0.5/*#-end-editable-code*/
//#-hidden-code
gameScene?.setGuidedMode(enabled:guidedModeEnabled)
gameScene?.setAcessibility(enabled:!visualRepresenationEnabled)
gameScene?.setVoicePlaybackSpeed(voicePlaybackSpeed:)
gameScene?.setChapter(chapter: level)
PlaygroundPage.current.liveView = vc
PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
//: [Next Page](@next)
