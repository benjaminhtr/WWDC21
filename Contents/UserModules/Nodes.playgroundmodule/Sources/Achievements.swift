import SpriteKit
import Models

public class Achievements: SKNode {
    
    // user interface nodes
    private var starsLabel: Label!
    private var trophiesLabel: Label!
    
    // init
    public required init(withBackground: Bool = true) {
        super.init()
        
        if withBackground {
            let background = SKSpriteNode(imageNamed: "achievementsNodeBackground")
            addChild(background)
        }
        
        // stars
        let starsContainer = SKSpriteNode(color: .clear, size: CGSize(width: 88, height: 42))
        starsContainer.position = CGPoint(x: -54, y: 0)
        addChild(starsContainer)
        
        starsLabel = Label(text: "0 ⭐️", font: .systemFont(ofSize: 28, weight: .bold))
        starsContainer.addChild(starsLabel)
        
        // trophies
        let trophiesContainer = SKSpriteNode(color: .clear, size: CGSize(width: 88, height: 42))
        trophiesContainer.position = CGPoint(x: 54, y: 0)
        addChild(trophiesContainer)
        
        trophiesLabel = Label(text: "0 🏆", font: .systemFont(ofSize: 28, weight: .bold))
        trophiesContainer.addChild(trophiesLabel)
        
        // dot in the middle
        let middleDot = SKShapeNode(circleOfRadius: 2)
        middleDot.fillColor = UIColor(white: 0, alpha: 0.3)
        addChild(middleDot)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // update node based on game stats
    public func update(_ gameStats: GameStats) {
        starsLabel.setText("\(gameStats.starsCount) ⭐️")
        trophiesLabel.setText("\(gameStats.trophiesCount) 🏆")
    }
    
}
