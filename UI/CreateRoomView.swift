import SwiftUI

/// Raum-Erstellung – Aprexity-UI.
struct CreateRoomView: View {
    @State private var selectedGame: LiveGame = LiveGame.all.first!
    @State private var roomTitle: String = ""
    @State private var darkMode = false
    
    let onCreate: (Room) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Spiel wählen") {
                    Picker("Spiel", selection: $selectedGame) {
                        ForEach(LiveGame.all, id: \.self) { game in
                            Text("\(game.title) (\(game.minPlayers)-\(game.maxPlayers))")
                                .tag(game)
                        }
                    }
                }
                
                Section("Session-Name") {
                    TextField("Meine Aprexity-Session", text: $roomTitle)
                }
                
                Section("Dark Mode") {
                    Toggle("Aktiv", isOn: $darkMode)
                        .onChange(of: darkMode) { _ in
                            UserDefaults.standard.set(darkMode, forKey: "darkMode")
                        }
                }
                
                Button("Session erstellen") {
                    let room = Room(
                        id: UUID(),
                        title: roomTitle.isEmpty ? selectedGame.title : roomTitle,
                        game: selectedGame,
                        maxPlayers: selectedGame.maxPlayers,
                        hostAvatar: nil,
                        currentPlayers: 1,
                        isPublic: true
                    )
                    onCreate(room)
                }
            }
            .navigationTitle("Neue Aprexity-Session")
        }
    }
}
