import Foundation

/// REST-Client – Aprexity-API-Endpunkte.
struct RoomAPI {
    private static let base = URL(string: "https://aprexity-api.fly.dev/api")!
    
    static func loadRooms() async throws -> [Room] {
        let (data, _) = try await URLSession.shared.data(from: base.appendingPathComponent("rooms"))
        return try JSONDecoder().decode([Room].self, from: data)
    }
    
    static func createRoom(_ game: LiveGame, title: String) async throws -> Room {
        var req = URLRequest(url: base.appendingPathComponent("rooms"))
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["gameType": game.id, "title": title]
        req.httpBody = try JSONEncoder().encode(body)
        let (data, _) = try await URLSession.shared.data(for: req)
        return try JSONDecoder().decode(Room.self, from: data)
    }
}
