//
//  ActionStep.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-09.
//

import Foundation

// MARK: - ActionStep

/// A single sub-step within a `StartupAction` (e.g. "read data").
/// Steps run in order and are what the console surfaces one at a time.
struct ActionStep {
    private let work: () throws -> Void
    private(set) var tearDown: () throws -> Void

    let name: String

    init(_ name: String, _ work: @escaping () -> Void, _ tearDown: @escaping () -> Void = {}) {
        self.name = name
        self.work = work
        self.tearDown = tearDown
    }

    func run() throws {
        try work()
    }
    
    
    func tear() throws {
        try tearDown()
    }
}
