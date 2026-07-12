//
//  LoadingConsoleView.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-06-03.
//

import SwiftUI

struct LoadingConsoleView: View {

    let actionName: String
    let progress: Double      // 0.0 – 1.0
    let errors: [String]

    /// Fixed height of the error console so its size stays stable
    /// whether or not there are errors to show.
    private let errorConsoleHeight: CGFloat = 180

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // MARK: Title
            Text(actionName.isEmpty ? "Klar" : actionName)
                .font(.headline)
                .foregroundStyle(actionName.isEmpty ? .secondary : .primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentTransition(.numericText())

            // MARK: Progress bar
            ProgressView(value: progress)
                .animation(.easeInOut, value: progress)

            // MARK: Error console
            if !errors.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(errors, id: \.self) { message in
                            Text(message)
                                .font(.caption)
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(8)
                }
                .frame(maxWidth: .infinity)
                .frame(height: errorConsoleHeight)
                .background(Color.red.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            } else {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.secondary.opacity(0.08))
                    .frame(maxWidth: .infinity)
                    .frame(height: errorConsoleHeight)
                    .overlay(
                        Text("Inga fel")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    )
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
    }
}

#Preview {
    VStack {
        Spacer()
        LoadingConsoleView(
            actionName: "Database – read data",
            progress: 0.66,
            errors: ["Error: connection timeout"]
        )
    }
    .padding(.bottom, 40)
}
