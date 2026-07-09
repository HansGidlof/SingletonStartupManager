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

    func startUp() {
        print("Network session started")
    }

    func tearDown() {
        print("Network session stopped")
    }
}
