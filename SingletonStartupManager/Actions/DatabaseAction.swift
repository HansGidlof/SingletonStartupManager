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

    func startUp() {
        print("Database connected")
    }

    func tearDown() {
        print("Database disconnected")
    }
}
