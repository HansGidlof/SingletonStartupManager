//
//  Lifecycle.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-06-03.
//

import Foundation

// MARK: - LifecycleProtocol

protocol LifecycleProtocol {
    func startUp() throws
    func tearDown() throws
}

// MARK: - Lifecycle

final class Lifecycle {

    // MARK: - Shared Instance

    /// The app-wide instance. Tests construct their own instance via `init`
    /// with a fake `LaunchTracking`.
    static let shared = Lifecycle()

    // MARK: - Actions

    var startUpActions: [StartupAction] = []
    var tearDownActions: [StartupAction] = []

    /// All errors collected during the last `startUp()` / `tearDown()` run.
    /// Empty when everything succeeded.
    private(set) var errors: [String] = []

    // MARK: - Dependencies

    /// Knows whether this is the app's first launch. Injected so it can be
    /// substituted in tests.
    private let launchTracker: LaunchTracking

    // MARK: - Init

    init(launchTracker: LaunchTracking = LaunchTracker()) {
        self.launchTracker = launchTracker
        configure()
    }

    // MARK: - Configure

    /// Builds the action list for this launch. First-launch-only actions are
    /// included only when the tracker reports the first launch.
    func configure() {
        let firstLaunchActions = launchTracker.isFirstLaunch ? ActionRegistry.firstLaunchOnly : []
        startUpActions = firstLaunchActions + ActionRegistry.everyLaunch
        tearDownActions = startUpActions.reversed()
    }

    // MARK: - Lifecycle

    /// Runs every startup action. Instead of crashing on the first failure,
    /// every error is collected into `errors` and the remaining actions still run.
    func startUp() {
        errors = []
        for action in startUpActions {
            do {
                try action.startUp()
            } catch {
                errors.append(error.localizedDescription)
            }
        }

        if launchTracker.isFirstLaunch {
            launchTracker.markLaunched()
        }
    }

    /// Runs every teardown action, collecting errors the same way as `startUp()`.
    func tearDown() {
        errors = []
        for action in tearDownActions {
            do {
                try action.tearDown()
            } catch {
                errors.append(error.localizedDescription)
            }
        }
    }
    
    
}
