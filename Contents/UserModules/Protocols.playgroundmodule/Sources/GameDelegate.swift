import Foundation
import Models

// the game delegate protocol
public protocol GameDelegate: class {
    func endGame(_ gameStats: GameStats)
}
