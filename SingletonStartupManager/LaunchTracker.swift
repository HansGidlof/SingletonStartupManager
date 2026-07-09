//
//  LaunchTracker.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-09.
//

import Foundation

// MARK: - LaunchTracking

/// Owns the "has the app launched before?" state. This is the single
/// collaborator responsible for reading and writing first-launch state,
/// so neither the actions nor `Lifecycle` touch persistence directly.
protocol LaunchTracking {
    /// `true` until `markLaunched()` has been called at least once.
    var isFirstLaunch: Bool { get }

    /// Records that the app has now completed a launch.
    func markLaunched()
}

// MARK: - LaunchTracker

/// `UserDefaults`-backed implementation of `LaunchTracking`.
struct LaunchTracker: LaunchTracking {

    private let defaults: UserDefaults
    private let hasLaunchedBeforeKey = "com.singletonstartupmanager.hasLaunchedBefore"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    var isFirstLaunch: Bool {
        !defaults.bool(forKey: hasLaunchedBeforeKey)
    }

    func markLaunched() {
        defaults.set(true, forKey: hasLaunchedBeforeKey)
    }
}
