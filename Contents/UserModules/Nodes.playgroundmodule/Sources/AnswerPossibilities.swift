import SpriteKit
import Models

public class AnswerPossibilities: SKNode {
    
    // current round's traffic signs and id
    private var correctTrafficSignId: Int
    private var currentTrafficSigns: [TrafficSign]
    
    // current answer nodes based on current traffic signs
    private var currentAnswerNodes = [AnswerNode]()
    
    // alphabet characters from a to z
    private let letters = (97...122).map({
        Character(UnicodeScalar($0)).uppercased()
    })
    
    // init
    public required init(correctTrafficSignId: Int, currentTrafficSigns: [TrafficSign]) {
        self.correctTrafficSignId = correctTrafficSignId
        self.currentTrafficSigns = currentTrafficSigns
        super.init()
        
        isUserInteractionEnabled = true
        
        // setup notification observers listening to answer node tap
        NotificationCenter.default.addObserver(self, selector: #selector(answerDidChoose), name: .answerNode, object: nil)
        
        setupAnswerNodes()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // setup answer nodes based on current traffic signs
    private func setupAnswerNodes() {
        currentAnswerNodes.removeAll()
        removeAllChildren()
        
        currentTrafficSigns.indices.forEach { index in
            let answerNode = AnswerNode(id: currentTrafficSigns[index].id, letter: letters[index], title: currentTrafficSigns[index].name)
            answerNode.position = CGPoint(x: 0, y: -72 * index)
            currentAnswerNodes.append(answerNode)
            addChild(answerNode)
        }
    }
    
    // start new round with given traffic signs
    public func startNewRound(correctTrafficSignId: Int, newTrafficSigns: [TrafficSign]) {
        self.correctTrafficSignId = correctTrafficSignId
        self.currentTrafficSigns = newTrafficSigns
        setupAnswerNodes()
    }
    
    // handle answer node tap from notification
    @objc private func answerDidChoose(_ notification: NSNotification) {
        
        // get id from tapped answer node via notificaton
        guard let id = notification.userInfo?["id"] as? Int else { return }
        
        // set answer node state
        currentAnswerNodes.enumerated().forEach { (index, answerNode) in
            if correctTrafficSignId == currentTrafficSigns[index].id {
                answerNode.state = .correct
            } else if currentTrafficSigns[index].id == id && correctTrafficSignId != id {
                answerNode.state = .wrong
            } else {
                answerNode.state = .hidden
            }
        }
        
    }
    
}
