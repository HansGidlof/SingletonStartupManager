//
//  LoggingAction.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-09.
//

import Foundation

// MARK: - LoggingAction

struct LoggingAction: StartupAction {
    let name = "Logging"

    func startUp() {
        print("Logging started")
    }

    func tearDown() {
        print("Logging stopped")
    }
}
