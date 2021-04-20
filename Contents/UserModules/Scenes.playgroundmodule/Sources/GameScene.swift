import SpriteKit
import Nodes
import Protocols
import Models


public class GameScene: SKScene {
    
    // total rounds for game
    private let totalRounds: Int
    
    // user interface nodes
    private var game: Game!
    private var feedbackPopup: FeedbackPopup!
    
    // init
    public required init(totalRounds: Int) {
        self.totalRounds = totalRounds
        super.init(size: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // scene did load
    public override func sceneDidLoad() {
        super.sceneDidLoad()
        
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // add game
        game = Game(totalRounds: totalRounds)
        game.delegate = self
        addChild(game)
        
        // add feedback popup
        feedbackPopup = FeedbackPopup()
        feedbackPopup.delegate = self
        addChild(feedbackPopup)
    }
    
}

extension GameScene: GameDelegate, FeedbackDelegate {
    
    // handle game end
    public func endGame(_ gameStats: GameStats) {
        game.hide()
        feedbackPopup.show(gameStats: gameStats)
    }
    
    // handle game start
    public func startGame() {
        game.startNewGame()
        feedbackPopup.hide()
    }
    
}
