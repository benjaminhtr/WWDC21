import SpriteKit
import Extensions

public class AnswerNode: SKNode {
    
    // the states an answer node can have
    public enum AnswerNodeState {
        case correct
        case wrong
        case hidden
        case normal
    }
    
    // set state
    public var state: AnswerNodeState = .normal {
        didSet {
            updateState(state)
        }
    }
    
    // the id of the answer node based on its traffic sign
    private var id: Int
    
    // feedback image node for check or xmark icon
    private var feedbackImageNode: SKSpriteNode!
    
    // init
    public required init(id: Int, letter: String, title: String) {
        self.id = id
        super.init()
        
        isUserInteractionEnabled = true
        
        // the background image
        let background = SKSpriteNode(imageNamed: "selectAnswerBackground")
        addChild(background)
        
        // letter label and its container
        let letterLabelContainer = SKSpriteNode(color: .clear, size: CGSize(width: 24, height: 24))
        letterLabelContainer.position = CGPoint(x: -162, y: 0)
        addChild(letterLabelContainer)
        
        let letterLabel = Label(text: letter, font: .systemFont(ofSize: 20, weight: .bold))
        letterLabelContainer.addChild(letterLabel)
        
        // title label and its container
        let titleLabelContainer = SKSpriteNode(color: .clear, size: CGSize(width: 262, height: 24))
        titleLabelContainer.position = CGPoint(x: -126, y: 0)
        titleLabelContainer.anchorPoint = CGPoint(x: 0, y: 0.5)
        addChild(titleLabelContainer)
        
        let titleLabel = Label(text: title, font: .systemFont(ofSize: 16, weight: .bold))
        titleLabel.horizontalAlignmentMode = .left
        titleLabelContainer.addChild(titleLabel)
        
        feedbackImageNode = SKSpriteNode()
        feedbackImageNode.size = CGSize(width: 20, height: 20)
        feedbackImageNode.position = CGPoint(x: 162, y: 0)
        addChild(feedbackImageNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // user touched node
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: .answerNode, object: nil, userInfo: ["id": id])
    }
    
    // set image for feedback image node
    private func setImage(named imageName: String) {
        feedbackImageNode.texture = SKTexture(imageNamed: imageName)
    }
    
    // set the answer node hidden with animation
    private func setHidden() {
        isUserInteractionEnabled = false
        
        let fadeAlpha = SKAction.fadeAlpha(to: 0.8, duration: 0.2)
        fadeAlpha.timingMode = .easeOut
        
        let scale = SKAction.scale(to: 0.98, duration: 0.2)
        scale.timingMode = .easeOut
        
        run(SKAction.group([fadeAlpha, scale]))
    }
    
    // update current state
    private func updateState(_ state: AnswerNodeState) {
        switch state {
        case .correct:
            isUserInteractionEnabled = false
            setImage(named: "check")
        case .wrong:
            isUserInteractionEnabled = false
            setImage(named: "xmark")
        case .hidden:
            setHidden()
        case .normal:
            isUserInteractionEnabled = true
            feedbackImageNode.texture = SKTexture()
        }
    }
    
    
}
