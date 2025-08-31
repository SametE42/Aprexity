import Foundation

/// WebSocket-Client – Aprexity-WSS.
final class GameSocketManager: ObservableObject {
    enum Status { case disconnected, connecting, connected }
    @Published var status: Status = .disconnected
    @Published var gameState: GameState?
    
    private var socket: URLSessionWebSocketTask?
    private var eventStore = EventStore()
    
    func connect(to roomID: UUID, token: String) {
        guard status != .connected else { return }
        status = .connecting
        guard let url = URL(string: "wss://aprexity-api.fly.dev/room/\(roomID.uuidString)") else { return }
        var req = URLRequest(url: url)
        req.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        socket = URLSession.shared.webSocketTask(with: url)
        socket?.resume()
        receive()
    }
    
    func sendEvent(_ event: GameEvent) {
        eventStore.record(event)
        let data = try! JSONEncoder().encode(event)
        socket?.send(.string(String(data: data, encoding: .utf8)!)) { _ in }
    }
    
    private func receive() {
        socket?.receive { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(.string(let text)):
                if let event = try? JSONDecoder().decode(GameEvent.self, from: Data(text.utf8)) {
                    let state = self.eventStore.replay()
                    DispatchQueue.main.async { self.gameState = state }
                }
                self.receive()
            case .failure:
                DispatchQueue.main.async { self.status = .disconnected }
            @unknown default: break
            }
        }
    }
}
