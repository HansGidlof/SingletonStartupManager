//
//  Lifecycle.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-06-03.
//

import Foundation

// MARK: - LifecycleProtocol

protocol LifecycleProtocol {
    func startUp()
    func tearDown()
}

// MARK: - Action

struct Action: LifecycleProtocol {
    let name: String
    var lastError: Error?
    private let onStartUp: () -> Void
    private let onTearDown: () -> Void

    init(name: String, onStartUp: @escaping () -> Void, onTearDown: @escaping () -> Void) {
        self.name = name
        self.onStartUp = onStartUp
        self.onTearDown = onTearDown
    }

    func startUp() {
        onStartUp()
    }

    func tearDown() {
        onTearDown()
    }
}

// MARK: - Lifecycle

final class Lifecycle {

    // MARK: - Shared Instance

    static let shared = Lifecycle()

    // MARK: - Actions

    var startUpActions: [Action] = []
    var tearDownActions: [Action] = []

    // MARK: - Init

    private init() {
        configure()
    }

    // MARK: - Configure

    private func configure() {
        startUpActions = [
            Action(
                name: "Logging",
                onStartUp: { print("Logging started") },
                onTearDown: { print("Logging stopped") }
            ),
            Action(
                name: "Database",
                onStartUp: { print("Database connected") },
                onTearDown: { print("Database disconnected") }
            ),
            Action(
                name: "Network",
                onStartUp: { print("Network session started") },
                onTearDown: { print("Network session stopped") }
            ),
        ]

        tearDownActions = startUpActions.reversed()
    }

    // MARK: - Lifecycle

    func startUp() {
        startUpActions.forEach { $0.startUp() }
    }

    func tearDown() {
        tearDownActions.forEach { $0.tearDown() }
    }
}
