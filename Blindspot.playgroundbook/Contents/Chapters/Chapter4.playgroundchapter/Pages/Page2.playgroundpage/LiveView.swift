import PlaygroundSupport
import SpriteKit

let vc = GameViewController()

let gameScene = vc.setUpGameScene()
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
var chapter:Chapter

chapter = ChapterBonus()

gameScene?.setAcessibility(enabled:true)
gameScene?.setChapter(chapter: chapter)
gameScene?.setCompletionNodeLastPageText()
PlaygroundPage.current.liveView = vc
PlaygroundPage.current.needsIndefiniteExecution = true
