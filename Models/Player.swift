import Foundation

/// Spieler-Objekt – Aprexity-Standard.
struct Player: Identifiable, Codable {
    let id: UUID
    let displayName: String
    let avatarURL: URL?
    var score: Int
}
