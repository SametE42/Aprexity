import Foundation

/// Repräsentiert ein einzelnes Ereignis im Spielverlauf.
enum GameEvent: Codable {
    case move(playerID: UUID, from: String, to: String)
    case resign(playerID: UUID)
    case drawOffer(playerID: UUID)
}

/// Speichert alle Ereignisse chronologisch.
struct EventStore {
    private var events: [GameEvent] = []
    
    mutating func record(_ event: GameEvent) {
        events.append(event)
    }
    
    func replay() -> GameState {
        events.reduce(into: GameState.initial) { state, event in
            state.applyEvent(event)
        }
    }
}
