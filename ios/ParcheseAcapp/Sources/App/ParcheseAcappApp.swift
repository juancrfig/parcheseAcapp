import SwiftUI

@main
struct ParcheseAcappApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to ParcheseAcapp")
                    .font(.title)
                    .padding()
                Text("Your go-to app for events in Colombia")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("ParcheseAcapp")
        }
    }
} 