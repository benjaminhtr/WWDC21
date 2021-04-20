import SpriteKit
import Protocols
import Models

public class FeedbackPopup: SKNode {
    
    // feedback types
    private enum FeedbackType {
        case flawless
        case medium
        case bad
    }
    
    // feedback delegate
    public weak var delegate: FeedbackDelegate?
    
    // user interface nodes
    private var titleLabel: Label!
    private var achievements: Achievements!
    private var descriptionLabel: Label!
    
    public override init() {
        super.init()
        
        // add background
        let background = SKSpriteNode(imageNamed: "feedbackPopupBackground")
        addChild(background)
 
        // add title label
        titleLabel = Label(font: .systemFont(ofSize: 24, weight: .bold))
        titleLabel.position = CGPoint(x: 0, y: 136)
        addChild(titleLabel)
        
        // add achievements
        achievements = Achievements(withBackground: false)
        achievements.position = CGPoint(x: 0, y: 68)
        addChild(achievements)
        
        // add description label
        descriptionLabel = Label(font: .systemFont(ofSize: 18, weight: .medium))
        descriptionLabel.position = CGPoint(x: 0, y: -24)
        addChild(descriptionLabel)
        
        // add play again button
        let playButton = Button(title: "Play again") {
            self.delegate?.startGame()
        }
        playButton.position = CGPoint(x: 0, y: -120)
        addChild(playButton)
        
        alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // get feedback type based on game stats
    private func getFeedbackType(from gameStats: GameStats) -> FeedbackType {
        if gameStats.starsCount == gameStats.totalRounds {
            return .flawless
        } else if gameStats.starsCount >= gameStats.totalRounds / 2 {
            return .medium
        } else {
            return .bad
        }
    }
    
    // show node with game stats
    public func show(gameStats: GameStats) {
        changeTypeAndPlaySound(getFeedbackType(from: gameStats), starsCount: gameStats.starsCount)
        achievements.update(gameStats)
        alpha = 1
    }
    
    // hide node
    public func hide() {
        alpha = 0
    }
    
    // change type of the node and play sound if needed
    private func changeTypeAndPlaySound(_ type: FeedbackType, starsCount: Int) {
        switch type {
        case .flawless:
            titleLabel.setText("Congratulations!")
            descriptionLabel.setText("What an impressive performance!\nNo incorrect answer. For that epic win\nyou’ll get a trophy! Want to play again?")
            let sound = SKAction.playSoundFileNamed("victory.mp3", waitForCompletion: false)
            run(sound)
        case .medium:
            titleLabel.setText("Not bad!")
            descriptionLabel.setText("You got \(starsCount) answers correct. There is not\nmuch left until you answer all correctly.\nKeep it up! Want to play again?")
        case .bad:
            titleLabel.setText("Game over!")
            descriptionLabel.setText("You only got \(starsCount) answers correct.\nDo you manage to recognize all the\nsigns correctly? Let’s try again.")
            let sound = SKAction.playSoundFileNamed("fail.mp3", waitForCompletion: false)
            run(sound)
        }
    }
    
    
}
