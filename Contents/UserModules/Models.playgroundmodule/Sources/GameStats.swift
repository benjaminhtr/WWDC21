import Foundation

// the game stats model
public class GameStats {
    
    // total rounds for one game
    // default is 8
    public var totalRounds: Int
    
    // count the rounds for one game
    // set progress when value changed
    public var roundCount: Int = 0 {
        didSet {
            progress = CGFloat(roundCount) / CGFloat(totalRounds)
        }
    }
    
    // the progress for one game
    public var progress: CGFloat = 0
    
    // count the stars for one game
    // ste the trophies after total rounds have been reached
    public var starsCount: Int = 0 {
        didSet {
            if starsCount == totalRounds {
                trophiesCount += 1
            }
        }
    }
    
    // count the rounds for all games
    public var trophiesCount: Int = 0
    
    // override total rounds if needed
    public init(totalRounds: Int = 8) {
        self.totalRounds = totalRounds
    }
    
    // start new round
    public func newRound() {
        roundCount += 1
    }
    
    // start new game
    public func newGame() {
        roundCount = 0
        starsCount = 0
    }
    
}
