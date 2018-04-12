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

var chapter = Chapter1()

gameScene?.setAcessibility(enabled:false)
gameScene?.setChapter(chapter: chapter)
PlaygroundPage.current.liveView = vc
PlaygroundPage.current.needsIndefiniteExecution = true
