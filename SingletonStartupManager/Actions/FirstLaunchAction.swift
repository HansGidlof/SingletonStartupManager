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

    func startUp() {
        print("First launch setup completed")
    }

    func tearDown() {
        print("First launch setup torn down")
    }
}
