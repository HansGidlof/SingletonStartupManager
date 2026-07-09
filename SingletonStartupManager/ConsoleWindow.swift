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
    @State private var progress: Double = 0
    @State private var errors: [String] = []

    /// All sub-steps across every action, flattened into a single ordered list
    /// paired with the action they belong to.
    private var steps: [(action: StartupAction, step: ActionStep)] {
        actions.flatMap { action in action.steps.map { (action, $0) } }
    }

    /// Label for the current step, e.g. "Database – read data".
    private var label: String {
        guard steps.indices.contains(currentIndex) else { return "" }
        let current = steps[currentIndex]
        return "\(current.action.name) – \(current.step.name)"
    }

    var body: some View {
        LoadingConsoleView(
            actionName: label,
            progress: progress,
            errors: errors
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.easeInOut, value: currentIndex)
        .animation(.easeInOut, value: progress)
        .task {
            let steps = self.steps
            for index in steps.indices {
                currentIndex = index
                errors = steps[index].action.lastError.map { [$0.localizedDescription] } ?? []
                progress = Double(index + 1) / Double(steps.count)
                try? await Task.sleep(for: .seconds(0.6))
            }

            // All steps complete: reset the progress bar and clear the log box.
            progress = 0
            errors = []
        }
    }
}

#Preview {
    ConsoleWindow()
        .frame(width: 360, height: 240)
}
