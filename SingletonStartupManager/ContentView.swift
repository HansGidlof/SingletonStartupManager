//
//  ContentView.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-06-03.
//

import SwiftUI

struct ContentView: View {

    let actions = Lifecycle.shared.startUpActions
    @State private var currentIndex = 0
    @State private var done = false

    var body: some View {
        VStack {
            Spacer()
            if !done, actions.indices.contains(currentIndex) {
                VStack(spacing: 8) {
                    Text("namn: \(actions[currentIndex].name)")
                        .transition(.opacity)
                        .id(currentIndex)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ProgressView(value: Double(currentIndex + 1), total: Double(actions.count))
                        .animation(.easeInOut, value: currentIndex)
                }
                .padding()
            }
        }
        .padding(.bottom, 40)
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
    ContentView()
}
