import SwiftUI

/// Spiel-Bildschirm – Aprexity-Look.
struct GameView: View {
    let room: Room
    @EnvironmentObject var socket: GameSocketManager
    
    var body: some View {
        VStack {
            Text("🎮  \(room.game.title)")
                .font(.largeTitle)
            Text("Spieler: \(room.currentPlayers)/\(room.maxPlayers)")
            // Platzhalter-Game-UI
        }
    }
}
