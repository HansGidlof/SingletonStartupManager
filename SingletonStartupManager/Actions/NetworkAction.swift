//
//  NetworkAction.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-09.
//

import Foundation

// MARK: - NetworkAction

struct NetworkAction: StartupAction {
    let name = "Network"

    var steps: [ActionStep] {
        [
            ActionStep("resolve host") { print("Network: host resolved") },
            ActionStep("open session") { print("Network: session opened") },
            ActionStep("warm connection") { print("Network: connection warmed") },
        ]
    }
}
