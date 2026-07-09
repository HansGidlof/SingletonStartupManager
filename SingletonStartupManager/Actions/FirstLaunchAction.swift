//
//  FirstLaunchAction.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-09.
//

import Foundation

// MARK: - FirstLaunchAction

/// One-time setup (e.g. onboarding). Registered in
/// `ActionRegistry.firstLaunchOnly`, so it runs only on the first launch.
struct FirstLaunchAction: StartupAction {
    let name = "First Launch Setup"

    var steps: [ActionStep] {
        [
            ActionStep("create defaults") { print("First launch: defaults created") },
            ActionStep("seed data") { print("First launch: data seeded") },
        ]
    }
}
