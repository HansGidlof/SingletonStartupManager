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
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(errors, id: \.self) { message in
                        Text(message)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color.red.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            } else {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.secondary.opacity(0.08))
                    .frame(maxWidth: .infinity, minHeight: 44)
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
