import Foundation

/// Spiel-Definition – Aprexity-Standard.
struct LiveGame: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let minPlayers: Int
    let maxPlayers: Int
    let category: Category
    
    enum Category: String, Codable, CaseIterable {
        case board, sports, classic
    }
    
    static let all: [LiveGame] = [
        .init(id: "chess",  title: "Schach",        minPlayers: 2, maxPlayers: 2, category: .board),
        .init(id: "ludo",   title: "Ludo",          minPlayers: 2, maxPlayers: 4, category: .classic),
        .init(id: "pool",   title: "Pool",          minPlayers: 2, maxPlayers: 2, category: .sports),
        .init(id: "soccer", title: "Table Soccer",  minPlayers: 2, maxPlayers: 2, category: .sports)
    ]
}
