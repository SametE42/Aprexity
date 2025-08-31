import SwiftUI
import UIKit

/// Einstiegspunkt der Aprexity-App.
@main
struct AprexityApp: App {
    @StateObject private var socket = GameSocketManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(socket)
        }
    }
}
