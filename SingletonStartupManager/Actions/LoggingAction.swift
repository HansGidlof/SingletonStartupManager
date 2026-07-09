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

    var steps: [ActionStep] {
        [
            ActionStep("open log file") { print("Logging: log file opened") },
            ActionStep("set level") { print("Logging: level set to debug") },
        ]
    }
}
