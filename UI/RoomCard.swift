import SwiftUI

/// Karten-UI – Aprexity-Style.
struct RoomCard: View {
    let room: Room
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(room.title)
                    .font(.headline)
                Text("\(room.currentPlayers)/\(room.maxPlayers) Spieler")
                    .font(.subheadline)
            }
            Spacer()
            Circle()
                .fill(room.isPublic ? Color.green : Color.gray)
                .frame(width: 10, height: 10)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}
