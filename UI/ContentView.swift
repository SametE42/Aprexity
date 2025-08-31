import SwiftUI

/// Hauptbildschirm – Aprexity-Look.
struct ContentView: View {
    @StateObject private var vm = RoomListViewModel()
    @StateObject private var socket = GameSocketManager()
    @State private var search = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.filteredRooms(search)) { room in
                    RoomCard(room: room)
                        .onTapGesture {
                            vm.join(room)
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                }
            }
            .navigationTitle("Aprexity")
            .searchable(text: $search)
            .refreshable {
                await vm.loadRooms()
            }
            .toolbar {
                Button("Neue Session", systemImage: "plus") {
                    vm.showCreate = true
                }
            }
            .sheet(isPresented: $vm.showCreate) {
                CreateRoomView { room in
                    vm.join(room)
                }
            }
            .sheet(item: $vm.selectedRoom) { room in
                GameView(room: room)
                    .environmentObject(socket)
            }
        }
    }
}
