//
//  iTourApp.swift
//  iTour
//
//  Created by Emirhan Gökçe on 7.05.2026.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: Destination.self)
    }
}
struct RootView: View {
    // Provide the required navigation path for ContentView
    @State var path: [Destination] = []

    var body: some View {
        ContentView(path: path)
    }
}

#Preview {
    RootView()
        .modelContainer(for: Destination.self)
}

