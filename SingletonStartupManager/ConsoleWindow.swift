//
//  ConsoleWindow.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-06-03.
//

import SwiftUI

struct ConsoleWindow: View {

    let actions = Lifecycle.shared.startUpActions
    @State private var currentIndex = 0
    @State private var done = false

    var body: some View {
        Group {
            if !done, actions.indices.contains(currentIndex) {
                LoadingConsoleView(
                    actionName: actions[currentIndex].name,
                    progress: Double(currentIndex + 1) / Double(actions.count),
                    errors: actions[currentIndex].lastError.map { [$0.localizedDescription] } ?? []
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .animation(.easeInOut, value: currentIndex)
        .animation(.easeInOut, value: done)
        .task {
            for index in actions.indices {
                currentIndex = index
                try? await Task.sleep(for: .seconds(1.5))
            }
            done = true
        }
    }
}

#Preview {
    ConsoleWindow()
        .frame(width: 360, height: 240)
}
