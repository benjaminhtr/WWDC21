import SpriteKit
import Models
import Protocols
import Extensions


public class Game: SKNode {
    
    // game stats - single source of truth for all games
    private let gameStats: GameStats
    
    // correct traffic sign for current round
    private var correctTrafficSign: TrafficSign {
        didSet {
            correctTrafficSignImageNode.texture = SKTexture(imageNamed: correctTrafficSign.imageName)
        }
    }
    
    // current traffic signs for current round
    private var currentTrafficSigns: [TrafficSign] {
        didSet {
            guard let randomCurrentTrafficSign = currentTrafficSigns.randomElement() else { fatalError("Could not get a random element from current traffic signs.") }
            correctTrafficSign = randomCurrentTrafficSign
        }
    }
    
    
    // user interface nodes
    private var progressLabel: Label!
    private var correctTrafficSignImageNode: SKSpriteNode!
    private var answerPossibilities: AnswerPossibilities!
    private var achievements: Achievements!
    
    // game delegate
    public weak var delegate: GameDelegate?
    
    // init
    public required init(totalRounds: Int) {
        
        gameStats = GameStats(totalRounds: totalRounds)
        
        // shuffle traffic signs and get first three results
        let shuffledTrafficSigns = trafficSigns.shuffled()
        currentTrafficSigns = Array(shuffledTrafficSigns[0..<3])
        
        // get ramdom traffic signs from shuffled which is going to be the correct one
        guard let randomCurrentTrafficSign = currentTrafficSigns.randomElement() else { fatalError("Could not get a random element from current traffic signs.") }
        correctTrafficSign = randomCurrentTrafficSign
        
        // set texture of correct traffic sign image node after its initialization
        defer {
            correctTrafficSignImageNode.texture = SKTexture(imageNamed: correctTrafficSign.imageName)
        }
        
        super.init()
        
        // add progress label
        progressLabel = Label(text: "Question \(gameStats.roundCount + 1) of \(gameStats.totalRounds)", font: .systemFont(ofSize: 16, weight: .bold))
        progressLabel.alpha = 0.5
        progressLabel.position = CGPoint(x: 0, y: 353)
        addChild(progressLabel)
        
        // add title label
        let titleLabel = Label(text: "What’s the meaning of\nthis traffic sign?", font: .systemFont(ofSize: 24, weight: .bold))
        titleLabel.position = CGPoint(x: 0, y: 300)
        addChild(titleLabel)
        
        // add sprite node for the current traffic sign image in order for the user to know what answer to click
        correctTrafficSignImageNode = SKSpriteNode()
        correctTrafficSignImageNode.size = CGSize(width: 226, height: 169)
        correctTrafficSignImageNode.position = CGPoint(x: 0, y: 155)
        addChild(correctTrafficSignImageNode)
        
        // add the answer possibilities after traffic signs have been initialized
        answerPossibilities = AnswerPossibilities(correctTrafficSignId: correctTrafficSign.id, currentTrafficSigns: currentTrafficSigns)
        addChild(answerPossibilities)
        
        // add achievements node to inform the user about their progress in the current game
        achievements = Achievements()
        achievements.position = CGPoint(x: 0, y: -325)
        addChild(achievements)
        
        // set up observers triggering a method to handle tapping on an answer from answer possibilities
        NotificationCenter.default.addObserver(self, selector: #selector(answerDidChoose), name: .answerNode, object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // start new game
    public func startNewGame() {
        alpha = 1
        
        gameStats.newGame()
        achievements.update(gameStats)
        progressLabel.setText("Question \(gameStats.roundCount + 1) of \(gameStats.totalRounds)")
        handleNewRound()
    }
    
    
    // hide the node
    public func hide() {
        alpha = 0
    }
    
    // handle tapping on an answer from answer possibilities
    @objc private func answerDidChoose(_ notification: NSNotification) {
        if let id = notification.userInfo?["id"] as? Int, id == correctTrafficSign.id {
            gameStats.starsCount += 1
            achievements.update(gameStats)
            
            let sound = SKAction.playSoundFileNamed("correct.mp3", waitForCompletion: false)
            run(sound)
        } else {
            let sound = SKAction.playSoundFileNamed("bonk.mp3", waitForCompletion: false)
            run(sound)
        }
        
        gameStats.newRound()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.handleNewRound()
        }
    }
    
    
    // fire delegate method if total rounds have been reached, otherwise start a new round
    private func handleNewRound() {
        progressLabel.setText("Question \(gameStats.roundCount + 1) of \(gameStats.totalRounds)")
        
        if gameStats.roundCount == gameStats.totalRounds {
            delegate?.endGame(gameStats)
        } else {
            let shuffledTrafficSigns = trafficSigns.shuffled()
            let newTrafficSigns = Array(shuffledTrafficSigns[0..<3])
            currentTrafficSigns = newTrafficSigns
            answerPossibilities.startNewRound(correctTrafficSignId: correctTrafficSign.id, newTrafficSigns: newTrafficSigns)
        }
    }
    
}

