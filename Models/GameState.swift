import Foundation

/// Reducer-basierter Spielstand – Aprexity-Engine.
struct GameState: Codable {
    var players: [Player] = []
    var board: [String:String] = [:]
    
    static let initial = GameState()
    
    mutating func applyEvent(_ event: GameEvent) {
        switch event {
        case .move(let pid, let from, let to):
            board[to] = board[from]; board[from] = nil
        case .resign(let pid):
            players.removeAll { $0.id == pid }
        case .drawOffer(let pid):
            break
        }
    }
}
