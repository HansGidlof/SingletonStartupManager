//
//  DatabaseAction.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-09.
//

import Foundation

// MARK: - DatabaseAction

struct DatabaseAction: StartupAction {
    let name = "Database"

    var steps: [ActionStep] {
        [
            ActionStep("read data") { print("Database: read data") },
            ActionStep("write data") { print("Database: write data") },
            ActionStep("cache") { print("Database: cache warmed") },
        ]
    }
}
