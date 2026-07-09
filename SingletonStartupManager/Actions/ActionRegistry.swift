//
//  ActionRegistry.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-09.
//

import Foundation

// MARK: - ActionRegistry

/// Central registry of all lifecycle actions.
///
/// *When* an action runs is decided by which list it is registered in — the
/// action type itself carries no scheduling flag. Order within a list defines
/// start-up order (tear-down runs in reverse).
enum ActionRegistry {

    /// Actions that run on every launch.
    static let everyLaunch: [StartupAction] = [
        LoggingAction(),
        DatabaseAction(),
        NetworkAction(),
    ]

    /// Actions that run only on the app's first launch.
    static let firstLaunchOnly: [StartupAction] = [
        FirstLaunchAction(),
    ]
}
