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

    func startUp() {
        do {
            try startUpActions.forEach { try $0.startUp() }
            
            if launchTracker.isFirstLaunch {
                launchTracker.markLaunched()
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func tearDown() {
        do {
            try tearDownActions.forEach { try $0.tearDown() }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    
}
