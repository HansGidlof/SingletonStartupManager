//
//  StartupAction.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-09.
//

import Foundation

// MARK: - StartupAction

/// A single lifecycle unit. Each concrete action lives in its own file
/// and is registered in `ActionRegistry`.
///
/// An action does not know *when* it runs — that is decided by which list
/// it is registered in (`everyLaunch` vs `firstLaunchOnly`). It exposes its
/// work as an ordered list of `steps`, which the console surfaces one at a time.
protocol StartupAction: LifecycleProtocol {
    /// Human-readable name shown in the console UI.
    var name: String { get }

    /// The ordered sub-steps that make up this action.
    var steps: [ActionStep] { get }

    /// The most recent error produced by the action, if any.
    var lastError: Error? { get }
}

// MARK: - Defaults

extension StartupAction {
    var lastError: Error? { nil }

    /// Runs every step in order.
    func startUp() throws {
        for var step in steps {
            try step.run()
        }
    }

    /// Runs the steps in reverse order for symmetry.
    func tearDown() throws {
        try steps.reversed().forEach { try $0.tearDown() }
    }
}
